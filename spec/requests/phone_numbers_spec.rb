require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/phone_numbers", type: :request do
  let(:user) { User.where(email: 'test_pn_requests@example.com').first_or_create(password: 'password', password_confirmation: 'password', otp_secret_key: User.otp_random_secret) }

  before :each do
    sign_in user
  end

  # This should return the minimal set of attributes required to create a valid
  # PhoneNumber. As you add validations to PhoneNumber, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      phone_type: 'text',
      number: '5555551212',
      code: user.otp_code
    }
  }

  let(:invalid_attributes) {
    {
      phone_type: 'text',
      number: '5555551212',
      code: 'invalid'
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      PhoneNumber.create! valid_attributes.merge(user: user)
      get phone_numbers_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      phone_number = PhoneNumber.create! valid_attributes.merge(user: user)
      get phone_number_url(phone_number)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_phone_number_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new PhoneNumber" do
        expect {
          post phone_numbers_url, params: { phone_number: valid_attributes }
        }.to change(PhoneNumber, :count).by(1)
      end

      it "redirects to the created phone_number" do
        post phone_numbers_url, params: { phone_number: valid_attributes }
        expect(response).to redirect_to(phone_number_url(PhoneNumber.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new PhoneNumber" do
        expect {
          post phone_numbers_url, params: { phone_number: invalid_attributes }
        }.to change(PhoneNumber, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post phone_numbers_url, params: { phone_number: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end
end