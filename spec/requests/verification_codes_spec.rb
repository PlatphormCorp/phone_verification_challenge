require 'rails_helper'

RSpec.describe "VerificationCodes", type: :request do
  let(:phone) { Phone.create(number: "3123074908") }

  describe "GET /" do
    it "returns http success" do
      get phone_verification_codes_path(phone)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /verify" do
    let(:verification_code) { VerificationCode.generate(phone) }

    it "sets a success flash if the code is correct" do
      post verify_phone_verification_codes_path(phone), params: { phone_id: phone.id, verification_code: { code: verification_code.code } }
      expect(flash[:success]).to eq("Your phone number has been verified")
    end

    it "sets an error flash if the code is correct" do
      post verify_phone_verification_codes_path(phone), params: { phone_id: phone.id, verification_code: { code: "lol bad code" } }
      expect(flash[:error]).to eq("The code you entered is incorrect")
    end
  end
end
