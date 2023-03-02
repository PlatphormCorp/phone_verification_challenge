class VerifyCodeController < ApplicationController
  def create # maybe just have one controller that handles all the verification stuff
    phone = Phone.find(params[:phone_id])
    verification = phone.phone_number_verifications.find_by(token: verification_params[:token])

    if verification.present?
      render json: verification
    else
      render json: { error_message: 'invalid code' }
    end
  end

  def verification_params # todo: there are double params coming through. I wonder if it's bc the controller is singular
    params.require(:phone_number_verification).permit(:token)
  end
end
