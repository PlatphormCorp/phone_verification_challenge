class VerifyClientError < StandardError # refacor this. Maybe move it to locales
  def initialize(message="Something bad happened in the verify client")
    super(message)
  end
end

class VerifyClient # name could be better
  CLIENT = Rails.application.credentials.phone_verification_client.development.client
  AUTH_CODE = Rails.application.credentials.phone_verification_client.development.authorization_code
  BASE_URL = Rails.application.credentials.phone_verification_client.development.base_url

  def initialize(phone_number:, verification_message:) # make these more general in case we want to do something else
    @phone_number = phone_number
    @verification_message = verification_message
  end

  def send_verification
    response = fire_post(verification_payload)

    if response.status == 500 # maybe move this response handling to another method
      # response.body example "The 'To' number +1+17726315044 is not a valid phone number."
      raise VerifyClientError.new(response.body)
    elsif response.status != 200
      raise VerifyClientError.new(response.body)
    else
      # "{\"result\":\"success\"}" successful response
      true
    end
  end

  private

  def fire_post(payload)
     conn = Faraday.new(
      url: BASE_URL,
      headers: { 'Content-Type' => 'application/json' }
    )

    conn.post('/sendsms') do |req|
      req.body = payload.to_json
    end
  end

  def verification_payload
    {
      "client": CLIENT,
      "authorization_code": AUTH_CODE,
      "phone_number": @phone_number,
      "message": @verification_message
    }
  end
end
