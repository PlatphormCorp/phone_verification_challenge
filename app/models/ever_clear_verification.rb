require 'faraday'

class EverClearVerification
  BASE_URI = 'https://fallow-badger-7481.twil.io'.freeze

  def self.send_verification_challenge(verify_phone)
    conn = Faraday.new(url: BASE_URI)
    options = {
      client: 'PhoneVerificationChallenge',
      phone_number: verify_phone.number,
      message: write_message(verify_phone.verification_code),
      authorization_code: ENV['AUTH_CODE']
    }
    response = conn.post('/sendsms', options)
    return response.status == 200 ? true : false
  end

  private

  def self.write_message(code)
    "Your verification code is #{code}."
  end
end
