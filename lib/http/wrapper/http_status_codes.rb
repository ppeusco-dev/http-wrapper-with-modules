# frozen_string_literal: true

module Http
  module Wrapper
    module HttpStatusCodes
      OK = :ok
      CREATED = :created
      ACCEPTED = :accepted
      NO_CONTENT = :no_content
      MOVED_PERMANENTLY = :moved_permanently
      FOUND = :found
      NOT_MODIFIED = :not_modified
      TEMPORARY_REDIRECT = :temporary_redirect
      PERMANENT_REDIRECT = :permanent_redirect
      BAD_REQUEST = :bad_request
      UNAUTHORIZED = :unauthorized
      FORBIDDEN = :forbidden
      NOT_FOUND = :not_found
      METHOD_NOT_ALLOWED = :method_not_allowed
      CONFLICT = :conflict
      UNPROCESSABLE_ENTITY = :unprocessable_entity
      TOO_MANY_REQUESTS = :too_many_requests
      INTERNAL_SERVER_ERROR = :internal_server_error
      BAD_GATEWAY = :bad_gateway
      SERVICE_UNAVAILABLE = :service_unavailable
      GATEWAY_TIMEOUT = :gateway_timeout
    end
  end
end
