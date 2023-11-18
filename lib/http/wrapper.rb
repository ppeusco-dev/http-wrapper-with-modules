# frozen_string_literal: true

require "faraday"

require "http/wrapper/version"
require "http/wrapper/http_status_codes"
require "http/wrapper/api_exceptions"
require "http/wrapper/configuration"
require "http/wrapper/error_mapping"
require "http/wrapper/request_handler"
require "http/wrapper/response_handler"
require "http/wrapper/client"

module Http
  module Wrapper
    class Error < StandardError; end
    # Your code goes here...
  end
end
