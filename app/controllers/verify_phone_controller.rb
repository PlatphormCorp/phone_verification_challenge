class VerifyPhoneController < ApplicationController
  def index
    @phone_number = PhoneNumber.new
  end

  def code
    @phone_number = PhoneNumber.find_by(number: phone_number_params[:number])
    @phone_number ||= PhoneNumber.create(number: phone_number_params[:number])

    if @phone_number.verified
      flash[:notice] = 'Phone number has already been verified.'
      return redirect_to root_path
    end

    if @phone_number.save && SmsSender.new(@phone_number).send_verification_code
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :index
    end
  end

  def verify
    @phone_number = PhoneNumber.find_by(number: phone_number_params[:number])

    if @phone_number.validate_code(phone_number_params[:verification_code])
      @phone_number.update_attribute(:verified, true)
      flash[:notice] = 'Your phone number has been verified.'
      redirect_to root_path
    else
      render :verify, status: :unprocessable_entity
    end
  end

  private

  def phone_number_params
    params.require(:phone_number).permit(:number, :verification_code)
  end
end
