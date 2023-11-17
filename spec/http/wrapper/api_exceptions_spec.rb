# frozen_string_literal: true

RSpec.describe Http::Wrapper::ApiExceptions do
  describe "exception classes" do
    it "defines BadRequestError with correct message" do
      error = Http::Wrapper::ApiExceptions::BadRequestError.new
      expect(error.message).to eq("Bad Request")
    end

    it "defines UnauthorizedError with correct message" do
      error = Http::Wrapper::ApiExceptions::UnauthorizedError.new
      expect(error.message).to eq("Unauthorized")
    end

    it "defines ForbiddenError with correct message" do
      error = Http::Wrapper::ApiExceptions::ForbiddenError.new
      expect(error.message).to eq("Forbidden")
    end

    it "defines NotFoundError with correct message" do
      error = Http::Wrapper::ApiExceptions::NotFoundError.new
      expect(error.message).to eq("Not Found")
    end

    it "defines UnprocessableEntityError with correct message" do
      error = Http::Wrapper::ApiExceptions::UnprocessableEntityError.new
      expect(error.message).to eq("Unprocessable Entity")
    end

    it "defines ApiRequestsQuotaReachedError with correct message" do
      error = Http::Wrapper::ApiExceptions::ApiRequestsQuotaReachedError.new
      expect(error.message).to eq("API rate limit exceeded")
    end

    it "defines InternalServerError with correct message" do
      error = Http::Wrapper::ApiExceptions::InternalServerError.new
      expect(error.message).to eq("Internal Server Error")
    end

    it "defines BadGatewayError with correct message" do
      error = Http::Wrapper::ApiExceptions::BadGatewayError.new
      expect(error.message).to eq("Bad Gateway")
    end

    it "defines ServiceUnavailableError with correct message" do
      error = Http::Wrapper::ApiExceptions::ServiceUnavailableError.new
      expect(error.message).to eq("Service Unavailable")
    end

    it "defines GatewayTimeoutError with correct message" do
      error = Http::Wrapper::ApiExceptions::GatewayTimeoutError.new
      expect(error.message).to eq("Gateway Timeout")
    end
  end

  describe "UnknownStatusError" do
    it "has the correct message based on status" do
      status = 404
      error = Http::Wrapper::ApiExceptions::UnknownStatusError.new(status)
      expect(error.message).to eq("Unknown Status: 404")
    end
  end
end
