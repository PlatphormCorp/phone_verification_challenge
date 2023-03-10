require 'rails_helper'

RSpec.describe VerifyPhone, type: :model do

  describe "phone number validation" do
    it "validates phone numbers with leading country codes" do
      phone_number = "+1 (555) 555-5555"
      verify_phone = VerifyPhone.create(number: phone_number)
      expect(verify_phone).to be_valid
    end

    it "validates phone numbers with dashes" do
      phone_number = "555-555-5555"
      verify_phone = VerifyPhone.create(number: phone_number)
      expect(verify_phone).to be_valid
    end

    it "validates phone numbers with slashes" do
      phone_number = "555/555/5555"
      verify_phone = VerifyPhone.create(number: phone_number)
      expect(verify_phone).to be_valid
    end

    it "validates phone numbers without special characters" do
      phone_number = "5555555555"
      verify_phone = VerifyPhone.create(number: phone_number)
      expect(verify_phone).to be_valid
    end

    it "fails validation for phone numbers that are too long" do
      phone_number = "55555555555"
      verify_phone = VerifyPhone.create(number: phone_number)
      expect(verify_phone).not_to be_valid
    end

    it "fails validation for phone numbers that are too short" do
      phone_number = "555555555"
      verify_phone = VerifyPhone.create(number: phone_number)
      expect(verify_phone).not_to be_valid
    end

    it "fails validation for duplicate phone numbers" do
      phone_number = "5555555555"
      VerifyPhone.create(number: phone_number)
      verify_phone = VerifyPhone.create(number: phone_number)
      expect(verify_phone).not_to be_valid
    end
  end

  describe "#generate_code" do
    it "creates a verification code" do
      verify_phone = VerifyPhone.create(number: "5555555555")
      verify_phone.generate_code
      expect(verify_phone.verification_code).not_to be_nil
    end
  end

end
