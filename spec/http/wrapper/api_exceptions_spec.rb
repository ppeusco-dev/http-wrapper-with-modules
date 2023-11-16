# frozen_string_literal: true

RSpec.describe Http::Wrapper::ApiExceptions do
  shared_examples_for "an exception with correct message" do |exception_class, message|
    it "defines #{exception_class} with correct message" do
      expect(described_class.const_get(exception_class).new.message).to eq(message)
    end
  end

  describe "exception classes" do
    context "standard exceptions" do
      include_examples "an exception with correct message", :BadRequestError, "Bad Request"
      include_examples "an exception with correct message", :UnauthorizedError, "Unauthorized"
      include_examples "an exception with correct message", :ForbiddenError, "Forbidden"
      include_examples "an exception with correct message", :NotFoundError, "Not Found"
      include_examples "an exception with correct message", :UnprocessableEntityError, "Unprocessable Entity"
    end

    context "rate limit exceptions" do
      include_examples "an exception with correct message", :ApiRequestsQuotaReachedError, "API rate limit exceeded"
    end

    context "server error exceptions" do
      include_examples "an exception with correct message", :InternalServerError, "Internal Server Error"
      include_examples "an exception with correct message", :BadGatewayError, "Bad Gateway"
      include_examples "an exception with correct message", :ServiceUnavailableError, "Service Unavailable"
      include_examples "an exception with correct message", :GatewayTimeoutError, "Gateway Timeout"
    end

    it "defines ApiError as a subclass of ApiExceptionError" do
      expect(described_class::ApiError.superclass).to eq(described_class::ApiExceptionError)
    end
  end
end
