# spec/controllers/verify_phone_controller_spec.rb
require 'rails_helper'


RSpec.describe VerifyPhoneController, type: :controller do
  describe 'POST #create' do
    let(:valid_phone_number) { '5551234567' }
    let(:invalid_phone_number) { '1234' }

    context 'with a valid phone number' do
      let(:ever_clear_verification_response) { true }

      before do
        allow(EverClearVerification).to receive(:send_verification_challenge)
          .with(an_instance_of(VerifyPhone))
          .and_return(ever_clear_verification_response)
      end

      it 'creates a VerifyPhone record and sends a verification challenge' do
        post :create, params: { phoneNumber: valid_phone_number }

        expect(response).to have_http_status(:success)

        verify_phone = VerifyPhone.find_by(number: valid_phone_number)

        expect(verify_phone).not_to be_nil
        expect(verify_phone.pending?).to be(true)
        expect(verify_phone.verification_code).not_to be_nil

        expect(EverClearVerification).to have_received(:send_verification_challenge)
          .with(verify_phone)
      end
    end

    context 'with an invalid phone number' do
      it 'returns an error message' do
        post :create, params: { phoneNumber: invalid_phone_number }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({"errors"=>[["Number is the wrong length (should be 10 characters)"]]})
      end
    end
  end
end
