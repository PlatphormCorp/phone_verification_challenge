require 'rails_helper'

RSpec.describe VerifyPhoneController, type: :controller do
  let(:valid_attributes) do
    {
      phone_number: "0123456789"
    }
  end

  let(:invalid_attributes) do
    {
      phone_number: "01234567"
    }
  end

  describe 'GET index' do
    before do
      get :index
    end

    it { is_expected.to redirect_to(new_verify_phone_path) }
  end

  describe 'GET new' do
    before do
      get :new
    end

    it { is_expected.to render_template(:index) }
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: verify_phone.id }
    end

    let(:verify_phone) { VerifyPhone.create(phone_number: '1123456789') }

    it { is_expected.to render_template(:index) }
  end

  describe 'POST create' do
    context 'with valid parameters and success http response' do
      before do
        success_response_mock = Net::HTTPSuccess.new(1.0, '200', 'OK')
        expect_any_instance_of(Net::HTTP).to receive(:request).and_return(success_response_mock)
      end

      it 'creates new Verify phone' do
        expect do
          post(:create, params: { verify_phone: valid_attributes })
        end.to change(VerifyPhone, :count).by(1)
      end

      it 'redirects to edit page' do
        post(:create, params: { verify_phone: valid_attributes })
        verify_phone = VerifyPhone.last
        expect(response).to redirect_to(edit_verify_phone_path(verify_phone.id))
      end
    end

    context 'with valid parameters and failure http response' do
      before do
        failure_response_mock = Net::HTTPSuccess.new(1.0, '500', 'Error')
        expect_any_instance_of(Net::HTTP).to receive(:request).and_return(failure_response_mock)
      end

      it 'creates new Verify phone' do
        expect do
          post(:create, params: { verify_phone: valid_attributes })
        end.to change(VerifyPhone, :count).by(1)
      end

      it 'redirects to new page' do
        post(:create, params: { verify_phone: valid_attributes })
        expect(response).to redirect_to(new_verify_phone_path)
      end
    end

    context 'with invalid parameters' do
      it "doesn't create new Verify phone" do
        expect do
          post(:create, params: { verify_phone: invalid_attributes })
        end.to change(VerifyPhone, :count).by(0)
      end

      it 'redirects to new page' do
        post(:create, params: { verify_phone: invalid_attributes })
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'POST update' do
    before do
      VerifyPhone.create(phone_number: '0123456789', verification_code: '235125')
    end

    context 'with valid verification code' do
      it 'redirects to new page' do
        patch(:update, params: { id: VerifyPhone.last.id, verify_phone: { verification_code: '235125' } })
        expect(response).to redirect_to(new_verify_phone_path)
      end
    end

    context 'with invalid verification code' do
      it 'redirects to edit page' do
        patch(:update, params: { id: VerifyPhone.last.id, verify_phone: { verification_code: '235115' } })
        expect(response).to redirect_to(edit_verify_phone_path(VerifyPhone.last.id))
      end
    end
  end
end
