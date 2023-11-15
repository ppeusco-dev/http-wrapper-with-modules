# frozen_string_literal: true

module Http
  module Wrapper
    module Client
      include ::Http::Wrapper::ApiExceptions
      include ::Http::Wrapper::HttpStatusCodes

      SUCCESSFUL_STATUS = [
        HTTP_OK_CODE, HTTP_CREATED_CODE
      ].freeze

      UNSUCCESSFUL_STATUS = [
        HTTP_BAD_REQUEST_CODE, HTTP_UNAUTHORIZED_CODE, HTTP_FORBIDDEN_CODE,
        HTTP_NOT_FOUND_CODE, HTTP_UNPROCESSABLE_ENTITY_CODE, HTTP_TOO_MANY_REQUEST,
        HTTP_INTERNAL_SERVER_ERROR_CODE, HTTP_BAD_GATEWAY_CODE, HTTP_SERVICE_UNAVAILABLE_CODE,
        HTTP_GATEWAY_TIMEOUT_CODE
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
        when HTTP_BAD_REQUEST_CODE then ApiExceptions.const_get("BadRequestError").new
        when HTTP_UNAUTHORIZED_CODE then ApiExceptions.const_get("UnauthorizedError").new
        when HTTP_FORBIDDEN_CODE then forbidden_error(response)
        when HTTP_NOT_FOUND_CODE then ApiExceptions.const_get("NotFoundError").new
        when HTTP_UNPROCESSABLE_ENTITY_CODE then ApiExceptions.const_get("UnprocessableEntityError").new
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
