class VerificationsController < ApplicationController

  def show
  end
  def create
    phone_verifier = PhoneVerifier.new(
      number: phone_number_params[:number],
      verification_code: phone_number_params[:verification_code]
    )
    result = phone_verifier.verify

    if result
      flash[:notice] = "Phone verified"
      redirect_to root_path
    else
      flash[:alert] = "Unable to verify phone, please try again"
      redirect_to root_path
    end
  end

  private
  def phone_number_params
    params.permit(:number, :verification_code)
  end
end