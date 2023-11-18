module Http
  module Wrapper
      module ResponseHandler
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
