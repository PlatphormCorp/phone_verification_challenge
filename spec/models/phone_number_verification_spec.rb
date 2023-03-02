require 'rails_helper'

RSpec.describe PhoneNumberVerification, type: :model do
  describe '#verification_message' do
    it 'includes a verification message' do
      phone_verification = build(:phone_number_verification)

      expect(phone_verification.verification_message).to include(
        'Thank you for joining, please verify by entering the following token:'
      )
    end
  end
end
