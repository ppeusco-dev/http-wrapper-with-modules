# frozen_string_literal: true

RSpec.describe Http::Wrapper::ApiExceptions do
  describe "exception classes" do
    it "defines BadRequestError with correct message" do
      expect(described_class::BadRequestError.new.message).to eq("Bad Request")
    end

    it "defines UnauthorizedError with correct message" do
      expect(described_class::UnauthorizedError.new.message).to eq("Unauthorized")
    end

    it "defines ForbiddenError with correct message" do
      expect(described_class::ForbiddenError.new.message).to eq("Forbidden")
    end

    it "defines NotFoundError with correct message" do
      expect(described_class::NotFoundError.new.message).to eq("Not Found")
    end

    it "defines UnprocessableEntityError with correct message" do
      expect(described_class::UnprocessableEntityError.new.message).to eq("Unprocessable Entity")
    end

    it "defines ApiRequestsQuotaReachedError with correct message" do
      expect(described_class::ApiRequestsQuotaReachedError.new.message).to eq("API rate limit exceeded")
    end

    it "defines InternalServerError with correct message" do
      expect(described_class::InternalServerError.new.message).to eq("Internal Server Error")
    end

    it "defines BadGatewayError with correct message" do
      expect(described_class::BadGatewayError.new.message).to eq("Bad Gateway")
    end

    it "defines ServiceUnavailableError with correct message" do
      expect(described_class::ServiceUnavailableError.new.message).to eq("Service Unavailable")
    end

    it "defines GatewayTimeoutError with correct message" do
      expect(described_class::GatewayTimeoutError.new.message).to eq("Gateway Timeout")
    end

    it "defines ApiError as a subclass of ApiExceptionError" do
      expect(described_class::ApiError.superclass).to eq(described_class::ApiExceptionError)
    end
  end
end
