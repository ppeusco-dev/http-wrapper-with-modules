# frozen_string_literal: true

class DummyClass
  include Http::Wrapper::Configuration
  include Http::Wrapper::RequestHandler

  attr_accessor :base_url, :api_endpoint, :headers

  def initialize(base_url, api_endpoint, headers = {})
    @base_url = base_url
    @api_endpoint = api_endpoint
    @headers = headers
    @faraday_options = {}
  end

  def configure_connection(options)
    @base_url = options[:base_url]
    @api_endpoint = options[:api_endpoint]
    @headers = options[:headers]
    @faraday_options = options[:faraday_options] || {}
  end

  def connection
    @connection ||= build_faraday_connection(@faraday_options).tap do |configured_conn|
      configure_faraday_headers(configured_conn, @headers)
    end
  end
end
