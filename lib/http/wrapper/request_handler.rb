module Http
  module Wrapper
    module RequestHandler
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
    end
  end
end
