# frozen_string_literal: true

module Http
  module Wrapper
    # Configuration module provides methods for configuring Faraday connections.
    module Configuration
      def connection(options = {})
        @connection ||= build_faraday_connection(options).tap do |configured_conn|
          configure_faraday_headers(configured_conn, options[:headers])
        end
      end

      private

      def build_faraday_connection(options)
        url = build_url(options[:base_url], options[:api_endpoint])
        url_with_scheme = add_scheme_to_url(url)

        faraday_options = options[:faraday_options] || {}

        Faraday.new(url_with_scheme, faraday_options) do |conn|
          conn.adapter Faraday.default_adapter
        end
      end

      def configure_faraday_headers(conn, headers)
        headers = build_headers(headers)

        headers.each do |key, value|
          conn.headers[key.to_s] = value.to_s
        end
      end

      def build_headers(headers)
        headers.each_with_object({}) { |(key, value), hash| hash[key.to_s] = value.to_s }
      end

      def build_url(base_url, api_endpoint)
        full_url = "#{base_url.to_s.chomp("/")}/#{api_endpoint.to_s.sub(%r{^/}, "")}"
        URI.parse(full_url).tap do |uri|
          uri.scheme = "http" unless uri.scheme =~ /^https?$/
        end.to_s
      end

      def add_scheme_to_url(url)
        uri = URI.parse(url)
        uri.scheme = "https" if uri.scheme.nil? || uri.scheme.empty?
        uri.to_s
      end
    end
  end
end
