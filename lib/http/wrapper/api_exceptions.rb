# frozen_string_literal: true

module Http
  module Wrapper
    # Module to encapsulate custom exceptions for the Http::Wrapper module.
    module ApiExceptions
      class ApiExceptionError < StandardError; end

      ApiError = Class.new(ApiExceptionError)

      [
        [:BadRequestError, "Bad Request"],
        [:UnauthorizedError, "Unauthorized"],
        [:ForbiddenError, "Forbidden"],
        [:NotFoundError, "Not Found"],
        [:UnprocessableEntityError, "Unprocessable Entity"],
        [:ApiRequestsQuotaReachedError, "API rate limit exceeded"],
        [:InternalServerError, "Internal Server Error"],
        [:BadGatewayError, "Bad Gateway"],
        [:ServiceUnavailableError, "Service Unavailable"],
        [:GatewayTimeoutError, "Gateway Timeout"]
      ].each do |exception, message|
        const_set(exception, Class.new(ApiError) do
          define_method(:initialize) { super(message) }
        end)
      end

      UnknownStatusError = Class.new(ApiError) do
        def initialize(status)
          super("Unknown Status: #{status}")
        end
      end
    end
  end
end
