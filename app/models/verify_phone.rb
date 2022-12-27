class VerifyPhone < ApplicationRecord
  attribute :verification_code_confirmation, :string
  validates :phone_number, length: 10..10, allow_blank: false
end
