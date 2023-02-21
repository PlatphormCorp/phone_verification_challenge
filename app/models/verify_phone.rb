class VerifyPhone < ApplicationRecord
  validates :phone_number, presence: true, numericality: true, length: { is: 10 }
end
