# NOTE: PhoneVerification is reserved name in this project.
class SmsPhoneVerification
  BASE_MESSAGE = "Your verification code is: ".freeze
  attr_reader :phone, :api

  def initialize(phone, api=nil)
    @phone = phone
    @api = api || ApiConnectionManager.new(phone_number: phone.number)
  end

  def send_verification
    verification_code = VerificationCode.generate(phone)
    message = BASE_MESSAGE + verification_code.code
    api.set_message(message)

    # TODO: The API we were provided with did not come with comprehensive
    # docs, so we're going to go out on a limb here and use an HTTP POST
    api.connection.post.status == 200
  end
end
