require 'rails_helper'

RSpec.describe VerifyPhone, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_numericality_of(:phone_number) }
    it { is_expected.to validate_length_of(:phone_number).is_equal_to(10) }
  end
end
