require 'rails_helper'

RSpec.describe VerifyPhone, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_numericality_of(:number) }
  end

  it 'generates a verification code on create' do
    subject = VerifyPhone.create(number: 443)
    expect(subject.verification_code).to be_present
    expect(subject.verification_code.length).to be(6)
  end

  describe '#validate_code' do
    it 'returns true when code is valid' do
      subject = VerifyPhone.create(number: 443)
      expect(subject.validate_code(subject.verification_code)).to be_truthy
    end

    it 'returns false when code is invalid' do
      subject = VerifyPhone.create(number: 443)
      expect(subject.validate_code(1234)).to be_falsy
    end
  end
end
