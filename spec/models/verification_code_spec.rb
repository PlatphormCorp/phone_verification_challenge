require 'rails_helper'

RSpec.describe VerificationCode, type: :model do
  it { should belong_to(:phone) }
  it { should validate_presence_of(:code) }
end
