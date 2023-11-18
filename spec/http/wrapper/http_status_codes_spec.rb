# frozen_string_literal: true

RSpec.describe Http::Wrapper::HttpStatusCodes do
  it { is_expected.to be_const_defined(:OK) }
  it { is_expected.to be_const_defined(:CREATED) }
  it { is_expected.to be_const_defined(:BAD_REQUEST) }
  it { is_expected.to be_const_defined(:UNAUTHORIZED) }
  it { is_expected.to be_const_defined(:FORBIDDEN) }
  it { is_expected.to be_const_defined(:NOT_FOUND) }
  it { is_expected.to be_const_defined(:UNPROCESSABLE_ENTITY) }
  it { is_expected.to be_const_defined(:TOO_MANY_REQUESTS) }
  it { is_expected.to be_const_defined(:INTERNAL_SERVER_ERROR) }
  it { is_expected.to be_const_defined(:BAD_GATEWAY) }
  it { is_expected.to be_const_defined(:SERVICE_UNAVAILABLE) }
  it { is_expected.to be_const_defined(:GATEWAY_TIMEOUT) }
end

RSpec.describe Http::Wrapper::HttpStatusCodes do
  describe "HTTP status codes" do
    it "defines HTTP_OK_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::OK).to eq(:ok)
    end

    it "defines HTTP_CREATED_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::CREATED).to eq(:created)
    end

    it "defines HTTP_BAD_REQUEST_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::BAD_REQUEST).to eq(:bad_request)
    end

    it "defines HTTP_UNAUTHORIZED_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::UNAUTHORIZED).to eq(:unauthorized)
    end

    it "defines HTTP_FORBIDDEN_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::FORBIDDEN).to eq(:forbidden)
    end

    it "defines HTTP_NOT_FOUND_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::NOT_FOUND).to eq(:not_found)
    end

    it "defines HTTP_UNPROCESSABLE_ENTITY_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::UNPROCESSABLE_ENTITY).to eq(:unprocessable_entity)
    end

    it "defines HTTP_TOO_MANY_REQUEST" do
      expect(Http::Wrapper::HttpStatusCodes::TOO_MANY_REQUESTS).to eq(:too_many_requests)
    end

    it "defines HTTP_INTERNAL_SERVER_ERROR_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::INTERNAL_SERVER_ERROR).to eq(:internal_server_error)
    end

    it "defines HTTP_BAD_GATEWAY_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::BAD_GATEWAY).to eq(:bad_gateway)
    end

    it "defines HTTP_SERVICE_UNAVAILABLE_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::SERVICE_UNAVAILABLE).to eq(:service_unavailable)
    end

    it "defines HTTP_GATEWAY_TIMEOUT_CODE" do
      expect(Http::Wrapper::HttpStatusCodes::GATEWAY_TIMEOUT).to eq(:gateway_timeout)
    end
  end
end
