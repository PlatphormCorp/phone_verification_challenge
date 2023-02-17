class VerificationCode < ApplicationRecord
  belongs_to :phone

  validates :code, presence: true

  scope :active, -> { where("expires_at > ?", Time.now) }

  def self.generate(phone)
    code = SecureRandom.hex(3)
    expires_at = Time.now + 5.minutes

    phone.verification_codes.create(code: code, expires_at: expires_at)
  end
end
