# frozen_string_literal: true

module Http
  module Wrapper
    module ApiExceptions
      class ApiExceptionError < StandardError; end

      [
        [:BadRequestError, 'Bad Request'],
        [:UnauthorizedError, 'Unauthorized'],
        [:ForbiddenError, 'Forbidden'],
        [:NotFoundError, 'Not Found'],
        [:UnprocessableEntityError, 'Unprocessable Entity'],
        [:ApiRequestsQuotaReachedError, 'API rate limit exceeded'],
        [:InternalServerError, 'Internal Server Error'],
        [:BadGatewayError, 'Bad Gateway'],
        [:ServiceUnavailableError, 'Service Unavailable'],
        [:GatewayTimeoutError, 'Gateway Timeout']
      ].each do |exception, message|
        const_set(exception, Class.new(ApiExceptionError) do
          define_method(:initialize) { super(message) }
        end)
      end

      ApiError = Class.new(ApiExceptionError)
    end
  end
end
