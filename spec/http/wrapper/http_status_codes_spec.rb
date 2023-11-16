# frozen_string_literal: true

RSpec.describe Http::Wrapper::HttpStatusCodes do
  context "defined constants" do
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

  describe "HTTP status codes" do
    describe_status_code :OK, :ok
    describe_status_code :CREATED, :created
    describe_status_code :BAD_REQUEST, :bad_request
    describe_status_code :UNAUTHORIZED, :unauthorized
    describe_status_code :FORBIDDEN, :forbidden
    describe_status_code :NOT_FOUND, :not_found
    describe_status_code :UNPROCESSABLE_ENTITY, :unprocessable_entity
    describe_status_code :TOO_MANY_REQUESTS, :too_many_requests
    describe_status_code :INTERNAL_SERVER_ERROR, :internal_server_error
    describe_status_code :BAD_GATEWAY, :bad_gateway
    describe_status_code :SERVICE_UNAVAILABLE, :service_unavailable
    describe_status_code :GATEWAY_TIMEOUT, :gateway_timeout
  end

  def describe_status_code(constant, symbol)
    it "defines HTTP_#{constant}_CODE" do
      expect(described_class.const_get(constant)).to eq(symbol)
    end
  end
end
