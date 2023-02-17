require 'rails_helper'

RSpec.describe SmsPhoneVerification do
  describe "#send_verification" do
    let(:phone) { double("phone", number: "555-555-5555") }
    let(:api) { double("api", set_message: nil, post: double("post", status: 200)) }
    let(:phone_verification) { SmsPhoneVerification.new(phone, api) }

    it "sends a verification code to the phone number through the given API" do
      expect(VerificationCode).to receive(:generate).with(phone).and_return(double("verification_code", code: "1234"))

      # Here we're testing that the API is called with the correct message.
      expect(api).to receive(:set_message).with("Your verification code is: 1234")
      expect(api).to receive(:connection).and_return(double("connection", post: double("post", status: 200)))
      phone_verification.send_verification
    end
  end
end
