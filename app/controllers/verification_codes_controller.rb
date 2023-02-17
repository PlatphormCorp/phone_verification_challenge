class VerificationCodesController < ApplicationController
  def index
    @phone = Phone.find(params[:phone_id])
  end

  # POST #verify
  def verify
    @phone = Phone.find(params[:phone_id])
    @verification_code = VerificationCode.find_by(verification_code_params)

    if @verification_code
      @phone.update(verification_expiration: 1.month.from_now)
      flash[:success] = "Your phone number has been verified"
    else
      flash[:error] = "The code you entered is incorrect"
    end
    render :index
  end

  def verification_code_params
    params.require(:verification_code).permit(:phone_id, :code)
  end
end
