# frozen_string_literal: true

RSpec.describe Http::Wrapper::HttpStatusCodes do
  it { is_expected.to be_const_defined(:HTTP_OK_CODE) }
  it { is_expected.to be_const_defined(:HTTP_CREATED_CODE) }
  it { is_expected.to be_const_defined(:HTTP_BAD_REQUEST_CODE) }
  it { is_expected.to be_const_defined(:HTTP_UNAUTHORIZED_CODE) }
  it { is_expected.to be_const_defined(:HTTP_FORBIDDEN_CODE) }
  it { is_expected.to be_const_defined(:HTTP_NOT_FOUND_CODE) }
  it { is_expected.to be_const_defined(:HTTP_UNPROCESSABLE_ENTITY_CODE) }
  it { is_expected.to be_const_defined(:HTTP_TOO_MANY_REQUEST) }
  it { is_expected.to be_const_defined(:HTTP_INTERNAL_SERVER_ERROR_CODE) }
  it { is_expected.to be_const_defined(:HTTP_BAD_GATEWAY_CODE) }
  it { is_expected.to be_const_defined(:HTTP_SERVICE_UNAVAILABLE_CODE) }
  it { is_expected.to be_const_defined(:HTTP_GATEWAY_TIMEOUT_CODE) }
end

RSpec.describe Http::Wrapper::HttpStatusCodes do
  describe 'HTTP status codes' do
    it 'defines HTTP_OK_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_OK_CODE).to eq(200)
    end

    it 'defines HTTP_CREATED_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_CREATED_CODE).to eq(201)
    end

    it 'defines HTTP_BAD_REQUEST_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_BAD_REQUEST_CODE).to eq(400)
    end

    it 'defines HTTP_UNAUTHORIZED_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_UNAUTHORIZED_CODE).to eq(401)
    end

    it 'defines HTTP_FORBIDDEN_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_FORBIDDEN_CODE).to eq(403)
    end

    it 'defines HTTP_NOT_FOUND_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_NOT_FOUND_CODE).to eq(404)
    end

    it 'defines HTTP_UNPROCESSABLE_ENTITY_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_UNPROCESSABLE_ENTITY_CODE).to eq(422)
    end

    it 'defines HTTP_TOO_MANY_REQUEST' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_TOO_MANY_REQUEST).to eq(429)
    end

    it 'defines HTTP_INTERNAL_SERVER_ERROR_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_INTERNAL_SERVER_ERROR_CODE).to eq(500)
    end

    it 'defines HTTP_BAD_GATEWAY_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_BAD_GATEWAY_CODE).to eq(502)
    end

    it 'defines HTTP_SERVICE_UNAVAILABLE_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_SERVICE_UNAVAILABLE_CODE).to eq(503)
    end

    it 'defines HTTP_GATEWAY_TIMEOUT_CODE' do
      expect(Http::Wrapper::HttpStatusCodes::HTTP_GATEWAY_TIMEOUT_CODE).to eq(504)
    end
  end
end
