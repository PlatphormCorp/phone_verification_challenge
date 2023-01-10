require 'rails_helper'

RSpec.describe PhoneVerifier do

  describe "verify" do
    it "should verify phone number if codes match" do
      phone_number = PhoneNumber.create(number: "1234567788")
      verification_code = VerificationCode.create(code: "123456", phone_number: phone_number)

      verifier = PhoneVerifier.new(number: phone_number.number, verification_code: verification_code.code)

      verifier.verify

      phone_number.reload

      expect(phone_number.verified?).to eq(true)
    end

    it "should not verify phone number if codes do not match" do
      phone_number = PhoneNumber.create(number: "1234567788")
      VerificationCode.create(code: "123456", phone_number: phone_number)

      verifier = PhoneVerifier.new(number: phone_number.number, verification_code: "999999")

      verifier.verify

      phone_number.reload

      expect(phone_number.verified?).to eq(false)
    end
  end
end
