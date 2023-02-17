require 'rails_helper'

RSpec.describe PhoneVerifier do
  # TODO: Factories would be nice via FactoryBot
  describe("#verify(Phone, VerificationCode)") do
    subject(:phone_verifier) { described_class.new(phone, verification_code) }

    context "given a Phone with an active, matching VerificationCode" do
      let(:verification_code) { VerificationCode.create(code: "1234", expires_at: 1.hour.from_now) }
      let(:phone) { Phone.create(number: "3123079148", verification_codes: [verification_code], verification_expiration: 10.years.from_now) }

      it "returns true if the code matches the phone's active verification codes" do
        expect(subject.verify(phone, verification_code)).to eq(true)
      end
    end

    context "given a Phone with an inactive, matching VerificationCode " do
      let(:verification_code) { VerificationCode.create(code: "1234", expires_at: 1.hour.ago) }
      let(:phone) { Phone.create(number: "3123079148", verification_codes: [verification_code], verification_expiration: 10.years.from_now) }

      it "returns true if the code matches the phone's active verification codes" do
        expect(subject.verify(phone, verification_code)).to eq(false)
      end
    end

    context "given a Phone with no VerificationCode " do
      let(:verification_code) { VerificationCode.create(code: "1234", expires_at: 1.hour.ago) }
      let(:phone) { Phone.create(number: "3123079148", verification_expiration: 10.years.from_now) }

      it "returns true if the code matches the phone's active verification codes" do
        expect(subject.verify(phone, verification_code)).to eq(false)
      end
    end
  end
end
