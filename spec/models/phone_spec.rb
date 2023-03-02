require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe '#create_and_verify' do
    it 'creates a phone and phone number verification record' do
      phone = build(:phone)
      expect_any_instance_of(VerifyClient).to receive(:send_verification)
      expect { phone.create_and_verify }.to change { Phone.count }.by(1)
              .and change { PhoneNumberVerification.count }.by(1)
    end

    it 'fails when a number is not Can or US' do
      phone = build(:phone, number: '12345669790000')
      result = phone.create_and_verify

      expect(result).to eq(false)
      expect(phone.errors.full_messages.to_sentence).to eq('Number is invalid and Phone validation failed: number is invalid') # need to work on this error message
    end

    it 'fails when a number is not Can or US' do
      phone = build(:phone)
      expect_any_instance_of(VerifyClient).to receive(:send_verification).and_raise('not good!')

      result = phone.create_and_verify
      expect(result).to eq(false)
      expect(phone.errors.full_messages.to_sentence).to eq('not good!')
    end
  end
end
