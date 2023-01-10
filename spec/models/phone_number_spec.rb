require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_numericality_of(:number) }
    it { is_expected.to validate_length_of(:number) }
  end
end
