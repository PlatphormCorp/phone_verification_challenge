class VerifyPhoneController < ApplicationController
  def create
    phone = Phone.find_or_initialize_by(phone_params)

    if phone.create_and_verify
      render json: phone
    else
      render json: { error_message: phone.errors.full_messages.to_sentence }
    end
  end

  def phone_params # todo: there are double params coming through. I wonder if it's bc the controller is singular
    params.require(:phone).permit(:number)
  end
end