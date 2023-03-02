require 'rails_helper'

RSpec.describe VerifyClient do
  describe '#send_verification' do
    let(:verification_message) { 'random_message' }
    let(:valid_phone_number) { '4074234093' }
    let(:response_double) { double('response_double') }
    let(:valid_params) do
      {
        authorization_code: "cool_auth_code",
        client: "cool_client",
        message: "random_message",
        phone_number: "4074234093"
      }
    end

    before do
      stub_const('VerifyClient::CLIENT', 'cool_client')
      stub_const('VerifyClient::AUTH_CODE', 'cool_auth_code')
      stub_const('VerifyClient::BASE_URL', 'cool_base_url')
    end

    it 'sends the proper params' do
      client = VerifyClient.new(phone_number: valid_phone_number, verification_message: verification_message)
      expect(response_double).to receive(:status).twice { 200 }
      expect(client).to receive(:fire_post).with(valid_params) { response_double }

      client.send_verification
    end

    context 'with errors' # to do
  end
end
