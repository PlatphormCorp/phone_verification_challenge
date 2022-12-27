require 'rails_helper'

describe VerifyPhoneController, type: :controller do
  describe "GET index" do
    subject { get :index }

    it "redirects to new" do
      expect(subject).to redirect_to action: :new
    end
  end

  describe "GET new" do
    subject { get :new }

    it "creates new instance of VerifyPhone" do
      subject
      expect(assigns(:verify_phone).class.name).to eq 'VerifyPhone'
    end

    it "renders verify_phone/index" do
      expect(subject).to render_template('verify_phone/index')
    end
  end

  describe "GET edit" do
    before :each do
      VerifyPhone.create(phone_number: '2025550143')
    end

    it "renders verify_phone/index" do
      get :edit, params: { id: VerifyPhone.last.id }
      expect(subject).to render_template('verify_phone/index')
    end
  end

  describe "POST create" do
    it "creates new instance of VerifyPhone" do
      # TODO: Ideally This should be recorded with VCR - https://github.com/vcr/vcr
      response_for_service_mock = Net::HTTPSuccess.new(1.0, '200', 'OK')
      expect_any_instance_of(Net::HTTP).to receive(:request).and_return(response_for_service_mock)

      post :create, params: { verify_phone: { phone_number: '2025550143' } }

      verify_phone = VerifyPhone.last
      expect(verify_phone.phone_number).to eq('2025550143')
      expect(verify_phone.verification_code).not_to be(nil)
      expect(verify_phone.verified_at).to be(nil)
      expect(subject).to redirect_to edit_verify_phone_path(id: verify_phone)
    end

    it "does not create new instance of VerifyPhone and returns 422 code when phone number is not valid" do
      expect_any_instance_of(Net::HTTP).not_to receive(:request)

      post :create, params: { verify_phone: { phone_number: '202555014' } }

      verify_phone = VerifyPhone.last
      expect(verify_phone).to be(nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT update" do
    before :each do
      VerifyPhone.create(phone_number: '2025550143', verification_code: '99998')
    end

    it "validates VerifyPhone when verification_code_confirmation matches verification_code" do
      # TODO: Ideally This should be recorded with VCR - https://github.com/vcr/vcr
      response_for_service_mock = Net::HTTPSuccess.new(1.0, '200', 'OK')
      expect_any_instance_of(Net::HTTP).to receive(:request).and_return(response_for_service_mock)

      put :update, params: {
        id: VerifyPhone.last,
        verify_phone: {
          phone_number: '2025550143',
          verification_code_confirmation: '99998'
        }
      }

      verify_phone = VerifyPhone.last
      expect(verify_phone.verified_at).not_to be(nil)
      expect(verify_phone.number_verified_confirmed_at).not_to be(nil)
      expect(subject).to redirect_to edit_verify_phone_path(id: verify_phone)
    end

    it "does NOT VerifyPhone when verification_code_confirmation doest NOT verification_code" do
      expect_any_instance_of(Net::HTTP).not_to receive(:request)

      put :update, params: {
        id: VerifyPhone.last,
        verify_phone: {
          phone_number: '2025550143',
          verification_code_confirmation: '11111'
        }
      }

      verify_phone = VerifyPhone.last
      expect(verify_phone.verified_at).to be(nil)
      expect(verify_phone.number_verified_confirmed_at).to be(nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end