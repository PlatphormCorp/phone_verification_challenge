require 'rails_helper'

RSpec.describe VerificationCode, type: :model do
  it { should belong_to(:phone) }
  it { should validate_presence_of(:code) }

  # TODO: Factories would be nice via FactoryBot
  describe "scopes" do
    describe ".active" do
      let(:phone) { Phone.create(number: "3123079148", verification_expiration: 10.years.from_now) }

      it "returns verification codes that are not expired" do
        active_code = VerificationCode.create(code: "1234", expires_at: 1.hour.from_now, phone: phone)
        inactive_code = VerificationCode.create(code: "1234", expires_at: 1.hour.ago, phone: phone)

        expect(VerificationCode.active).to include(active_code)
        expect(VerificationCode.active).to_not include(inactive_code)
      end
    end
  end

  describe ".generate(phone)" do
    let(:phone) { Phone.create(number: "3123079148", verification_expiration: 10.years.from_now) }

    it "generates a reasonably hard to guess code that is still human input friendly" do
      secure_code = "123456"
      allow(SecureRandom).to receive(:hex).and_return(secure_code)

      verification_code = VerificationCode.generate(phone)
      expect(verification_code.code).to eq(secure_code)
    end

    it "sets the expiration to 5 minutes from now" do
      verification_code = VerificationCode.generate(phone)
      expect(verification_code.expires_at).to be_within(1.second).of(5.minutes.from_now)
    end
  end
end
