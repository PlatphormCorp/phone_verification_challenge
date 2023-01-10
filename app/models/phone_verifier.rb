class PhoneVerifier
  attr_reader :number, :verification_code

  def initialize(number:, verification_code:)
    @number = number
    @verification_code = verification_code
  end

  def verify
    phone_number = PhoneNumber.find_by_number(number)

    code_in_system = VerificationCode.where(phone_number: phone_number).last

    if code_in_system.code == verification_code.to_i
      phone_number.update(verified: true)
    end

    phone_number.verified?
  end
end