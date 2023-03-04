class SmsSender
  attr_reader :phone_number

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def send_verification_code
    return false unless phone_number.verification_code

    message = "Please use the following code to verify your phone number: #{phone_number.verification_code}"
    response = client.post('/sendsms') do |req|
      req.params['phone_number'] = phone_number.number
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
