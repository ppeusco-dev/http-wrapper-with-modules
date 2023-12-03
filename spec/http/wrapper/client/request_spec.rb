# frozen_string_literal: true

require_relative "../../../dummy_class"

RSpec.describe Http::Wrapper::RequestHandler do
  let(:dummy_instance) { DummyClass.new("https://api.example.com", "/path", { "Authorization" => "Bearer 1234567890" }) }
  let(:connection_double) { instance_double(Faraday::Connection) }

  describe "#send_request" do
    context "with valid params type" do
      it "sends a query request when params type is :query" do
        allow(connection_double).to receive(:get)

        dummy_instance.send_request(connection_double, :get, "/path", { key: "value" }, :query)

        expect(connection_double).to have_received(:get).with("/path", { key: "value" })
      end

      it "sends a body request when params type is :body" do
        allow(dummy_instance).to receive(:perform_body_request)

        dummy_instance.send_request(connection_double, :post, "/path", { key: "value" }, :body)

        expect(dummy_instance).to have_received(:perform_body_request).with(connection_double, :post, "/path",
                                                                            { key: "value" })
      end
    end

    context "with unknown params type" do
      it "raises an error" do
        expect { dummy_instance.send_request(connection_double, :get, "/path", { key: "value" }, :invalid_type) }
          .to raise_error(RuntimeError, "Unknown params type: invalid_type")
      end
    end
  end

  describe "#perform_body_request" do
    it "sends a body request with correct parameters" do
    end
  end
end
