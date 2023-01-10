class VerificationRequestsController < ApplicationController
  def create
    verification_request = VerificationRequest.new(number: phone_number_params[:number])
    verification_request.send
    redirect_to verification_path(number: phone_number_params[:number])
  end

  private
  def phone_number_params
    params.permit(:number, :verification_code)
  end
end