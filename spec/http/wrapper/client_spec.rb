# frozen_string_literal: true

RSpec.describe Http::Wrapper::Client do
  include Http::Wrapper::HttpStatusCodes
  include Http::Wrapper::ApiExceptions

  let(:dummy_class) { Class.new { extend Http::Wrapper::Client } }
  let(:dummy_endpoint) { 'http://endpoint.test' }
  let(:dummy_headers) { {} }
  let(:connect) { dummy_class.connection(dummy_endpoint, dummy_headers) }

  shared_examples 'a successful response' do |status|
    let(:response) { instance_double(Faraday::Response, status:, body: '{"key":"value"}') }

    before do
      allow(dummy_class).to receive(:connection).and_return(connect)
      allow(connect).to receive(:get).and_return(response)
    end

    it 'returns the parsed response' do
      parsed_response = dummy_class.request(
        connection: connect,
        http_method: :get,
        endpoint: '/api/endpoint',
        params_type: :query,
        params: { param: 'value' }
      )

      expect(parsed_response).to eq({ 'key' => 'value' })
    end
  end

  shared_examples 'an unsuccessful response' do
    let(:client_response) { instance_double(Faraday::Response) }

    before do
      allow(dummy_class).to receive(:connection).and_return(connect)
      allow(connect).to receive(:get).and_return(client_response)
      allow(client_response).to receive(:status).and_return(status)
      allow(client_response).to receive(:body).and_return('{"error":"Error message"}')
    end

    it 'raises the expected error' do
      expect do
        dummy_class.request(
          connection: connect,
          http_method: :get,
          endpoint: '/api/endpoint',
          params_type: :query,
          params: { param: 'value' }
        )
      end.to raise_error(error_class, "Code: #{status}, response: {\"error\":\"Error message\"}")
    end
  end

  describe '.connection' do
    it 'be an instance of Faraday::Connection' do
      expect(connect).to be_an_instance_of Faraday::Connection
    end
  end

  describe '.request' do
    context 'when the response is successful' do
      include_examples 'a successful response', Http::Wrapper::HttpStatusCodes::HTTP_OK_CODE
      include_examples 'a successful response', Http::Wrapper::HttpStatusCodes::HTTP_CREATED_CODE
    end

    context 'when the response is unsuccessful' do
      context 'when the response is a bad request' do
        let(:status) { Http::Wrapper::HttpStatusCodes::HTTP_BAD_REQUEST_CODE }
        let(:error_class) { Http::Wrapper::ApiExceptions::BadRequestError }

        include_examples 'an unsuccessful response', Http::Wrapper::HttpStatusCodes::HTTP_BAD_REQUEST_CODE,
                         Http::Wrapper::ApiExceptions::BadRequestError
      end

      context 'when the response status is unknown' do
        let(:status) { 999 }
        let(:error_class) { Http::Wrapper::ApiExceptions::ApiError }

        include_examples 'an unsuccessful response', Http::Wrapper::HttpStatusCodes::HTTP_BAD_REQUEST_CODE,
                         Http::Wrapper::ApiExceptions::ApiError
      end
    end
  end
end
