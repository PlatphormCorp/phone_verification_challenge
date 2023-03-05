class SmsSender
  attr_reader :verify_phone

  def initialize(verify_phone)
    @verify_phone = verify_phone
  end

  def send_verification_code
    return false unless verify_phone.verification_code

    message = "Please use the following code to verify your phone number: #{verify_phone.verification_code}"
    response = client.post('/sendsms') do |req|
      req.params['phone_number'] = verify_phone.number
      req.params['message'] = message
    end

    response.success?
  end

  def verify_code; end

  private

  def client
    @client ||= Faraday.new(
      url: 'https://fallow-badger-7481.twil.io',
      params: {
        client: ENV['TWILIO_CLIENT'],
        authorization_code: ENV['TWILIO_AUTHORIZATION']
      }
    )
  end
end
