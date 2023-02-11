
class PhoneNumber < ApplicationRecord
  VALID_TYPES = %w[voice text]

  belongs_to :user, optional: true

  validates :phone_type, inclusion: { in: PhoneNumber::VALID_TYPES }
  validates :number, uniqueness: true
  validate :code_is_valid

  attr_accessor :code

  def self.validate_number(user:, phone_number:)
    service = EverclearApiService.new
    message = "Your phone number has been added for the email '#{user.email}' to use with the Everclear application.  Please enter the following code: #{user.otp_code}"
    api_response = service.send_sms(phone_number: phone_number, message: message)
  end

  def code_is_valid
    valid_number = self.phone_type == 'voice' || user.authenticate_otp(self.code || '', drift: 300)
    self.errors.add(:code, :invalid) if !valid_number
    self.validated = valid_number
  end
end
