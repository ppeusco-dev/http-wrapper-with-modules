module Http
  module Wrapper
    module ErrorMapping

      include ::Http::Wrapper::HttpStatusCodes
      
      ERROR_MAPPING = {
        OK => nil,
        CREATED => nil,
        ACCEPTED => nil,
        NO_CONTENT => nil,
        MOVED_PERMANENTLY => nil,
        FOUND => nil,
        NOT_MODIFIED => nil,
        TEMPORARY_REDIRECT => nil,
        PERMANENT_REDIRECT => nil,
        BAD_REQUEST => ApiExceptions.const_get("BadRequestError").new,
        UNAUTHORIZED => ApiExceptions.const_get("UnauthorizedError").new,
        FORBIDDEN => ->(response) { forbidden_error(response) },
        NOT_FOUND => ApiExceptions.const_get("NotFoundError").new,
        UNPROCESSABLE_ENTITY => ApiExceptions.const_get("UnprocessableEntityError").new,
        TOO_MANY_REQUESTS => ApiExceptions.const_get("ApiRequestsQuotaReachedError").new,
        INTERNAL_SERVER_ERROR => ApiExceptions.const_get("InternalServerError").new,
        BAD_GATEWAY => ApiExceptions.const_get("BadGatewayError").new,
        SERVICE_UNAVAILABLE => ApiExceptions.const_get("ServiceUnavailableError").new,
        GATEWAY_TIMEOUT => ApiExceptions.const_get("GatewayTimeoutError").new,
        DEFAULT => ApiExceptions.const_get("ApiError").new
      }.freeze
    end
  end
end

