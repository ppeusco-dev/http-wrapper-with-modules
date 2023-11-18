# frozen_string_literal: true

module Http
  module Wrapper
    # Module to encapsulate HTTP client functionality for the Http::Wrapper module.
    module Client
      include ::Http::Wrapper::ApiExceptions
      include ::Http::Wrapper::HttpStatusCodes
      include ::Http::Wrapper::Configuration

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
        GATEWAY_TIMEOUT => ApiExceptions.const_get("GatewayTimeoutError").new,
        DEFAULT => ApiExceptions.const_get("ApiError").new
      }.freeze

      def request(connection:, http_method:, endpoint:, params_type: :query, params: {})
        @response = send_request(connection, http_method, endpoint, params, params_type)
        handle_response
      end

      private

      def send_request(connection, http_method, endpoint, params, params_type)
        request_methods = {
          query: -> { connection.public_send(http_method, endpoint, params) },
          body: -> { perform_body_request(connection, http_method, endpoint, params) }
        }

        request_method = request_methods[params_type] || (raise "Unknown params type: #{params_type}")
        request_method.call
      end

      def perform_body_request(connection, _http_method, endpoint, params)
        connection.get(endpoint) do |req|
          req.headers[:content_type] = "application/json"
          req.body = params
          req.adapter Faraday.default_adapter
        end
      end

      def handle_response
        parsed_response = Oj.load(@response.body)

        return parsed_response if response_successful?

        raise error_class, "Code: #{@response.status}, response: #{@response.body}"
      end

      def error_class
        ERROR_MAPPING[@response.status] || UnknownStatusError.new(@response.status)
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
    end
  end
end
