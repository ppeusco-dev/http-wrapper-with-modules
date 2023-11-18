module Http
  module Wrapper
    module Configuration
      def connection(api_endpoint, headers, faraday_options = {})
        @connection ||= faraday_connection(faraday_options) do |conn|
          conn.url_prefix = api_endpoint
          conn.headers = headers 
        end
      end

      private

      def faraday_connection(options = {})
        Faraday.new(options) do |conn|
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end
