# frozen_string_literal: true

module Http
  module Wrapper
    module Client
      include ::Http::Wrapper::ApiExceptions
      include ::Http::Wrapper::HttpStatusCodes

      SUCCESSFUL_STATUS = [
        OK,
        CREATED,
        ACCEPTED,
        NO_CONTENT,
        MOVED_PERMANENTLY,
        FOUND,
        NOT_MODIFIED,
        TEMPORARY_REDIRECT,
        PERMANENT_REDIRECT
      ].freeze

      UNSUCCESSFUL_STATUS = [
        BAD_REQUEST,
        UNAUTHORIZED,
        FORBIDDEN,
        NOT_FOUND,
        METHOD_NOT_ALLOWED,
        CONFLICT,
        UNPROCESSABLE_ENTITY,
        TOO_MANY_REQUESTS,
        INTERNAL_SERVER_ERROR,
        BAD_GATEWAY,
        SERVICE_UNAVAILABLE,
        GATEWAY_TIMEOUT
      ].freeze

      ERROR_MAPPING = {
        OK => nil,
        CREATED => nil,
        ACCEPTED => nil,
        NO_CONTENT => nil,
        MOVED_PERMANENTLY => nil,
        FOUND => nil,
        NOT_MODIFIED => nil,
        TEMPORARY_REDIRECT => nil,
        PERMANENT_REDIRECT => nil,
        BAD_REQUEST => ApiExceptions.const_get("BadRequestError").new,
        UNAUTHORIZED => ApiExceptions.const_get("UnauthorizedError").new,
        FORBIDDEN => ->(response) { forbidden_error(response) },
        NOT_FOUND => ApiExceptions.const_get("NotFoundError").new,
        UNPROCESSABLE_ENTITY => ApiExceptions.const_get("UnprocessableEntityError").new,
        TOO_MANY_REQUESTS => ApiExceptions.const_get("ApiRequestsQuotaReachedError").new,
        INTERNAL_SERVER_ERROR => ApiExceptions.const_get("InternalServerError").new,
        BAD_GATEWAY => ApiExceptions.const_get("BadGatewayError").new,
        SERVICE_UNAVAILABLE => ApiExceptions.const_get("ServiceUnavailableError").new,
        GATEWAY_TIMEOUT => ApiExceptions.const_get("GatewayTimeoutError").new
        # Puedes agregar más mapeos según sea necesario
      }.freeze

      def connection(api_endpoint, headers)
        @connection ||= Faraday.new(api_endpoint) do |conn|
          conn.adapter Faraday.default_adapter
          conn.headers = headers
        end
      end

      def request(connection:, http_method:, endpoint:, params_type: :query, params: {})
        @response = abstract_request(connection, http_method, endpoint, params, params_type)

        parsed_response = Oj.load(@response.body)

        return parsed_response if response_successful?

        raise error_class, "Code: #{@response.status}, response: #{@response.body}"
      end

      private

      def error_class
        ERROR_MAPPING[@response.status] || ApiError.new
      end

      def response_successful?
        SUCCESSFUL_STATUS.include?(@response.status)
      end

      def api_requests_quota_reached?
        @response.body.match?(API_REQUESTS_QUOTA_REACHED_MESSAGE)
      end

      def forbidden_error(response)
        return ApiExceptions.const_get("ApiRequestsQuotaReachedError").new if api_requests_quota_reached?(response)
      
        ApiExceptions.const_get("ForbiddenError").new
      end      

      def abstract_request(connection, http_method, endpoint, params, params_type)
        case params_type
        when :query
          connection.public_send(http_method, endpoint, params)
        when :body
          connection.get endpoint do |req|
            req.headers[:content_type] = "application/json"
            req.body = params
          end
        else
          raise "Unknown params type: #{params_type}"
        end
      end
    end  
  end
end
