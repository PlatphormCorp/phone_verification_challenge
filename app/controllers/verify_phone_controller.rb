class VerifyPhoneController < ApplicationController
  def index
  end

  def create
    phone_number = params[:phoneNumber]
    verify_phone = VerifyPhone.find_or_initialize_by(number: phone_number)
    puts "verify_phone in controller #{verify_phone.inspect}}"

    if !verify_phone.valid?
      errors = verify_phone.errors.full_messages
      render json: { errors: [errors] }, status: :unprocessable_entity
    elsif verify_phone.verified?
      render json: { status: 'success', message: 'already verified' }
    else
      verify_phone.generate_code
      ever_clear_verification = EverClearVerification.send_verification_challenge(verify_phone)
      puts "ever_clear_verification: #{ever_clear_verification}"

      if ever_clear_verification
        verify_phone.pending!
        verify_phone.save
        render json: { status: 'success', message: 'check phone for verification code' }
      else
        render json: { errors: ['invalid phone number'] }, status: :unprocessable_entity
      end
    end
  end

   def verification_code
    phone_number = params[:phoneNumber]
    verification_code = params[:verificationCode]
    verify_phone = VerifyPhone.find_by(number: phone_number)
    if verify_phone.verification_code === verification_code.to_i
      verify_phone.verified!
      render json: { status: 'success' }
    else
      render json: { errors: ['Verificaiton code is invalid'] }, status: :unprocessable_entity
    end
  end
end
