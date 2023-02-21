require 'net/http'

class PhoneVerifier
  attr_accessor :phone_number

  VERIFICATION_URL = "https://fallow-badger-7481.twil.io/sendsms".freeze
  CLIENT = "PhoneVerificationChallenge".freeze

  def initialize(phone_number:)
    @phone_number = phone_number
  end

  def send_verification_code
    code = SecureRandom.random_number(10e5).to_i
    response = send_request("Your verification code is: #{code}")
    if response.code == '200'
      { status: 'success', code: code }
    else
      { status: 'error' }
    end
  end

  private

  def send_request(message)
    uri = URI(VERIFICATION_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = {
      phone_number: phone_number,
      client: CLIENT,
      authorization_code: ENV['API_AUTH_KEY'],
      message: message
    }.to_json
    request['Content-Type'] = 'application/json'
    http.request(request)
  end
end
