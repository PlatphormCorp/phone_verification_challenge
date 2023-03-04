class VerifyPhone < ApplicationRecord
  before_create :set_verification_code

  validates :number, presence: true, numericality: true

  def set_verification_code
    self.verification_code = rand(10**6).to_s
  end

  def validate_code(code)
    return true if verification_code == code

    errors.add(:base, 'Incorrect verification code.') and return false
  end
end
