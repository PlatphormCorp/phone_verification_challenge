require 'rails_helper'

RSpec.describe "Phones", type: :request do
  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    context "when the phone number is valid and a verification is successfully sent" do
      let(:sms_phone_verification_double) { double("SmsPhoneVerification", send_verification: true) }
      let(:phone_number) { "3123074908" }

      it "sets a success flash message" do
        allow(SmsPhoneVerification).to receive(:new).and_return(sms_phone_verification_double)

        expect(post "/", params: { phone: { number: phone_number } }).to redirect_to(phone_verification_codes_path(phone_id: Phone.find_by(number: phone_number).id))
        expect(flash[:success]).to eq("Verification code sent.")
      end
    end

    context "SmsPhoneVerification fails to send a verification" do
      let(:sms_phone_verification_double) { double("SmsPhoneVerification", send_verification: false) }

      it "sets an error flash message" do
        allow(SmsPhoneVerification).to receive(:new).and_return(sms_phone_verification_double)

        post "/", params: { phone: { number: "3123074908" } }
        expect(flash[:error]).to eq("There was an issue sending the verification code. Customer support has been notified.")
        expect(response).to have_http_status(:success)
      end
    end

    context "when the phone number is invalid" do
      it "renders the new template" do
        post "/", params: { phone: { number: "So scarlet, it was maroon" } }
        expect(response).to render_template(:new)
      end
    end
  end
end
