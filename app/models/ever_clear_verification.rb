require 'httparty'
require 'dotenv/load'


class EverClearVerification
  include HTTParty
  base_uri 'https://fallow-badger-7481.twil.io'

  def self.send_verification_challenge(verify_phone)

    
    options = {
      body: { 
        client: 'PhoneVerificationChallenge', 
        phone_number: verify_phone.number, 
        message: write_message(verify_phone.verification_code),
        authorization_code: ENV['AUTH_CODE'] }
    }

    response = post('/sendsms', options)

    if response.code == 200
      return true
    else
      return false
    end
  end

  
  private 

  def self.write_message(code)
    "Your verification code is #{code}."
  end
end
