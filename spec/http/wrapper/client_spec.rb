# frozen_string_literal: true

RSpec.describe Http::Wrapper::Client do
  include Http::Wrapper::HttpStatusCodes
  include Http::Wrapper::ApiExceptions

  let(:dummy_class) { Class.new { extend Http::Wrapper::Client } }
  let(:dummy_endpoint) { "http://endpoint.test" }
  let(:dummy_headers) { {} }
  let(:connect) { dummy_class.connection(dummy_endpoint, dummy_headers) }

  describe ".connection" do
    it "be an instance of Faraday::Connection" do
      expect(connect).to be_an_instance_of Faraday::Connection
    end
  end

  describe ".request" do
    context "when the response is successful" do
      include_examples "a successful response", Http::Wrapper::HttpStatusCodes::OK
      include_examples "a successful response", Http::Wrapper::HttpStatusCodes::CREATED
    end

    context "when the response is unsuccessful" do
      context "when the response is a bad request" do
        include_examples "an unsuccessful response", Http::Wrapper::HttpStatusCodes::BAD_REQUEST,
                         Http::Wrapper::ApiExceptions::BadRequestError
      end

      context "when the response status is unknown" do
        include_examples "an unsuccessful response", 999,
                         Http::Wrapper::ApiExceptions::UnknownStatusError
      end
    end
  end
end
