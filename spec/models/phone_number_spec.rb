require 'rails_helper'

RSpec.describe 'PhoneNumber', type: :model do
  describe 'model' do
    let(:user) { User.create(email: 'test_phone_number_model@example.com', password: 'password', password_confirmation: 'password', otp_secret_key: User.otp_random_secret) }
    it "does not save if no code is present" do
      phone_number = user.phone_numbers.new( number: '555-555-1212', phone_type: 'text' )
      expect(phone_number.valid?).to equal(false)
    end
    it "does not save if number is not unique" do
      user.save
      phone_number = user.phone_numbers.create( number: '555-555-1212', phone_type: 'text' )
      phone_number = user.phone_numbers.new( number: '555-555-1212', phone_type: 'text' )
      expect(phone_number.valid?).to equal(false)
    end
    it "does not save if phone_type is not valid" do
      phone_number = user.phone_numbers.new( number: '555-555-1212', phone_type: 'invalid' )
      expect(phone_number.valid?).to equal(false)
    end
    it "does pass code_is_valid if phone_type is 'voice'" do
      phone_number = user.phone_numbers.new( number: '555-555-1212', phone_type: 'voice' )
      expect(phone_number.code_is_valid).to equal(true)
    end
    it "does pass code_is_valid if phone_type is 'text' and code is valid" do
      code = user.otp_code
      phone_number = user.phone_numbers.new( number: '555-555-1212', phone_type: 'text', code: code )
      expect(phone_number.code_is_valid).to equal(true)
    end
    it "does NOT pass code_is_valid if phone_type is 'text' and code is NOT valid" do
      code = user.otp_code
      phone_number = user.phone_numbers.new( number: '555-555-1212', phone_type: 'text', code: 'invalid' )
      expect(phone_number.code_is_valid).to equal(false)
    end
  end
end
