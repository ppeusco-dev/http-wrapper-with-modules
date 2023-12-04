# frozen_string_literal: true

module Http
  module Wrapper
    # Module to encapsulate HTTP client functionality for the Http::Wrapper module.
    module Client
      include ::Http::Wrapper::Configuration
      include ::Http::Wrapper::ErrorHandling
      include ::Http::Wrapper::RequestHandler
      include ::Http::Wrapper::ResponseHandler

      def request(base_url:, http_method:, endpoint:, params_type: :query, params: {})
        connection = connection(base_url: base_url, api_endpoint: endpoint, headers: headers)

        @response = send_request(connection, http_method, endpoint, params, params_type)
        handle_response
      end
    end
  end
end
