require 'rails_helper'

RSpec.describe SmsSender do
  let(:verify_phone) { VerifyPhone.create(number: 1_112_223_333) }

  describe '#send_verification_code' do
    it 'sends a verification code to the phone number and returns true when successful' do
      response_dbl = instance_double('Faraday::Response')
      expect_any_instance_of(Faraday::Connection).to receive(:post)
        .with('/sendsms')
        .and_return(response_dbl)
      allow(response_dbl).to receive(:success?).and_return(true)

      sender = described_class.new(verify_phone)
      expect(sender.send_verification_code).to be_truthy
    end

    it 'returns false when unsuccessful' do
      response_dbl = instance_double('Faraday::Response')
      expect_any_instance_of(Faraday::Connection).to receive(:post)
        .with('/sendsms')
        .and_return(response_dbl)
      allow(response_dbl).to receive(:success?).and_return(false)

      sender = described_class.new(verify_phone)
      expect(sender.send_verification_code).to be_falsy
    end
  end
end
