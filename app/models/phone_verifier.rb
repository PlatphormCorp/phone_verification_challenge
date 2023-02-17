class PhoneVerifier
  attr_reader :phone, :verification_code
  attr_accessor :errors
  def initialize(phone, verification_code)
    @phone = phone
    @verification_code = verification_code
  end

  def verify(phone, verification_code)
    if phone.verification_codes.active.where(id: verification_code.id).empty?
      return false
    end

    true
  end
end
