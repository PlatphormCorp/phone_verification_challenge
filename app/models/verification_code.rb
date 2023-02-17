class VerificationCode < ApplicationRecord
  belongs_to :phone

  validates :code, presence: true
end
