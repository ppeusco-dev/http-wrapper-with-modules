# frozen_string_literal: true

module Http
  module Wrapper
    # Module to encapsulate HTTP client functionality for the Http::Wrapper module.
    module Client
      include ::Http::Wrapper::ApiExceptions
      include ::Http::Wrapper::Configuration
      include ::Http::Wrapper::ErrorMapping
      include ::Http::Wrapper::RequestHandler

      def request(connection:, http_method:, endpoint:, params_type: :query, params: {})
        @response = send_request(connection, http_method, endpoint, params, params_type)
        handle_response
      end

      private

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
