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

      # TODO: To refactor this methods is necessary map the error codes with the error classes
      def error_class
        case @response.status
        when BAD_REQUEST then ApiExceptions.const_get("BadRequestError").new
        when UNAUTHORIZED then ApiExceptions.const_get("UnauthorizedError").new
        when FORBIDDEN then forbidden_error(response)
        when NOT_FOUND then ApiExceptions.const_get("NotFoundError").new
        when UNPROCESSABLE_ENTITY then ApiExceptions.const_get("UnprocessableEntityError").new
        else
          ApiError.new
        end
      end

      private

      def response_successful?
        SUCCESSFUL_STATUS.include?(@response.status)
      end

      def api_requests_quota_reached?
        @response.body.match?(API_REQUESTS_QUOTA_REACHED_MESSAGE)
      end

      def forbidden_error
        return ApiExceptions.const_get("ApiRequestsQuotaReachedError") if api_requests_quota_reached?(@response)

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
