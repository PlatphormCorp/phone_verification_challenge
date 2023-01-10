class VerificationRequest
  attr_reader :number

  VERIFICATION_URL = "https://fallow-badger-7481.twil.io/sendsms".freeze
  CLIENT = "PhoneVerificationChallenge".freeze
  def initialize(number:)
    @number = number
  end
  def send
    HTTParty.post(VERIFICATION_URL, query: query_parameters)
  end

  private
  def generate_and_persist_code
    # lifted this from this SO - https://stackoverflow.com/questions/44031239/generating-random-number-of-length-6-with-securerandom-in-ruby
    code = (SecureRandom.random_number(9e5) + 1e5).to_i

    phone_number = PhoneNumber.find_or_create_by(number: number)

    verification_code = VerificationCode.create(code: code, phone_number: phone_number, expires_at: 30.minutes.from_now)

    verification_code.code
  end

  def message
    "You can verify your phone by entering this code on the home page. Your code is #{generate_and_persist_code}"
  end

  def query_parameters
    {
      client: CLIENT,
      authorization_code: Rails.application.credentials[:authorization_code],
      phone_number: number,
      message: message
    }
  end
end