require 'rails_helper'

RSpec.describe VerifyPhoneController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:phone_number) { '2345678909' }
      
      before do
        allow(EverClearVerification).to receive(:send_verification_challenge).and_return(true)
        post :create, params: { phoneNumber: phone_number }
      end
      
      it 'generates verification code' do
        verify_phone = VerifyPhone.find_by(number: phone_number)
        expect(verify_phone.reload.verification_code).to be_present
      end

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      let(:phone_number) { '' }
      let(:verify_phone) { build_stubbed(:verify_phone, number: phone_number) }

      before do
        allow(EverClearVerification).to receive(:send_verification_challenge).and_return(false)
        post :create, params: { phoneNumber: phone_number }
      end

      it 'returns unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        expect(response.body).to include("Number can't be blank")
      end
    end

    context 'when phone number is already verified' do
      let(:phone_number) { '2345678909' }
      let(:verify_phone) { create(:verify_phone, number: phone_number, status: :verified) }

      before do
        post :create, params: { phoneNumber: phone_number }
      end

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end

      it 'returns already verified message' do
        expect(response.body).to include('check phone for verification code')
      end
    end
  end

  describe 'POST #verification_code' do
    let(:phone_number) { '2345678909' }
    let(:verification_code) { 123456 }
    
    context 'with valid verification code' do
      before do
        @verify_phone = create(:verify_phone, number: phone_number, verification_code: verification_code)
        post :verification_code, params: { phoneNumber: phone_number, verificationCode: verification_code }
      end

      it 'updates verify phone status to verified' do
        expect(@verify_phone.reload.status).to eq('verified')
      end

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid verification code' do
      let(:phone_number) { '2345678909' }
      let(:true_verification_code) { 123456 }
      let(:wrong_verification_code) { 999 }
      
      before do
        @verify_phone = create(:verify_phone, number: phone_number, verification_code: true_verification_code)
        post :verification_code, params: { phoneNumber: phone_number, verificationCode: wrong_verification_code }
      end

      it 'returns unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        expect(response.body).to include('Verification code is invalid')
      end
    end
  end
end
