# frozen_string_literal: true

require_relative "../../../dummy_class"

RSpec.describe Http::Wrapper::Configuration do
  let(:faraday_double) { instance_double(Faraday::Connection, url_prefix: URI.parse("https://api.example.com")) }
  let(:dummy_class) { DummyClass.new("https://api.example.com", "/path", { "Authorization" => "Bearer 1234567890" }) }

  before do
    allow_any_instance_of(Faraday::Connection).to receive(:url_prefix).and_return(URI.parse(dummy_class.base_url))
  end

  describe "#connection" do
    let(:base_options) do
      {
        base_url: "https://api.example.com",
        api_endpoint: "/path",
        headers: { "Authorization" => "Bearer 1234567890" },
        faraday_options: { connection: faraday_double }
      }
    end

    context "basic connection" do
      before do
        dummy_class.instance_variable_set(:@connection, nil)
        dummy_class.configure_connection(base_options)
      end

      it "creates a Faraday connection" do
        connection = dummy_class.connection
        expect(connection).to be_a(Faraday::Connection)
      end

      it "creates a Faraday connection with the specified URL prefix" do
        connection = dummy_class.connection
        expect(connection.url_prefix.to_s).to eq("https://api.example.com")
      end
    end

    context "headers" do
      before do
        dummy_class.instance_variable_set(:@connection, nil)
        dummy_class.configure_connection(base_options)
      end

      it "creates a Faraday connection with the specified headers" do
        connection = dummy_class.connection
        expect(connection.headers).to include("Authorization" => "Bearer 1234567890")
      end
    end

    context "additional options" do
      let(:ssl_options) { { verify: true } }

      before do
        dummy_class.instance_variable_set(:@connection, nil)
        dummy_class.configure_connection(base_options.merge(faraday_options: { ssl: ssl_options }))
      end

      it "passes additional options to the Faraday connection" do
        connection = dummy_class.connection
        expect(connection.ssl.verify?).to be(true)
      end
    end
  end
end
