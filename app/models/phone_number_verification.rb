class PhoneNumberVerification < ApplicationRecord
  belongs_to :phone

  before_create :set_token

  def verification_message
    "Thank you for joining, please verify by entering the following token: #{token}"
  end

  private

  def set_token
    self.token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(3)
      break token unless PhoneNumberVerification.where(token: token).exists?
    end
  end
end
