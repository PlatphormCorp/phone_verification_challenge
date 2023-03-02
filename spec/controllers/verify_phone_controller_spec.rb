require 'rails_helper'

RSpec.describe VerifyPhoneController, type: :controller do
  describe '#create' do
    it 'returns a phone' do
      post 'create', params: {phone: { number: 8183459392 }}

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to include({"number"=>"8183459392"})
    end

    it 'returns an error message' do
      post 'create', params: {phone: { number: 'not a nunber' }}

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['error_message']).to include("Number is invalid and Phone validation failed: number is invalid")
    end
  end
end
