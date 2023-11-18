# frozen_string_literal: true

module Http
  module Wrapper
    module ResponseHandler
      private

      def handle_response
        parsed_response = Oj.load(@response.body)

        return parsed_response if response_successful?

        raise error_class, "Code: #{@response.status}, response: #{@response.body}"
      end

      def response_successful?
        SUCCESSFUL_STATUS.include?(@response.status)
      end
    end
  end
end
