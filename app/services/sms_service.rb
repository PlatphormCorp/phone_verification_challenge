require 'net/http'

class SmsService
  def generate_and_send_code(verify_phone)
    random_code = rand(10000..99999)

    response = get_response_from_api(verify_phone.phone_number, "Your verification code is: #{random_code}")

    if response.code == '200'
      verify_phone.update(verification_code: random_code)
      return true
    end
    false
  end

  def verify_code_for_phone_number(verify_phone, verification_code_confirmation)

    if verify_phone.verification_code != verification_code_confirmation
      return false
    end

    verify_phone.update(verified_at: DateTime.now)
    response = get_response_from_api(verify_phone.phone_number, "Your phone number is now verified")

    if response.code == '200'
      verify_phone.update(
        number_verified_confirmed_at: DateTime.now
      )
      return true
    end
    false
  end

  private
  def get_response_from_api(phone_number, message)
    uri = URI(SMS_API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = {
      phone_number: phone_number,
      client: SMS_API_CLIENT,
      authorization_code: SMS_API_AUTH_KEY,
      message: message
    }.to_json
    request['Content-Type'] = 'application/json'
    http.request(request)
  end
end

