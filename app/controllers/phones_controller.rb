class PhonesController < ApplicationController
  ERROR_FLASH = "There was an issue sending the verification code. Customer support has been notified.".freeze
  SUCCESS_FLASH = "Verification code sent.".freeze
  def new
    @phone = Phone.new
  end

  def create
    @phone = Phone.find_or_create_by(phone_params)

    if @phone.valid?
      if SmsPhoneVerification.new(@phone).send_verification
        flash[:success] = SUCCESS_FLASH
        redirect_to '/' && return
      else
        flash[:error] = ERROR_FLASH
      end
    else
      render :new
    end
  end
  alias_method :update, :create

  def phone_params
    params.require(:phone).permit(:number)
  end
end
