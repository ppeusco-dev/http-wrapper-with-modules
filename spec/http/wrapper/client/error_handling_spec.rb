# frozen_string_literal: true

RSpec.describe Http::Wrapper::ErrorHandling do
  let(:dummy_class) { Class.new { extend Http::Wrapper::ErrorHandling } }

  describe "#error_class" do
    it "returns the correct error class based on the response status" do
      # Write test cases to cover different response status codes and their corresponding error classes
    end
  end

  describe "#api_requests_quota_reached?" do
    it "returns true if the API requests quota is reached" do
      # Write test cases to cover scenarios where the API requests quota is reached
    end
  end

  describe "#forbidden_error" do
    it "returns the correct error class based on the response" do
      # Write test cases to cover different response scenarios for forbidden errors
    end
  end
end
