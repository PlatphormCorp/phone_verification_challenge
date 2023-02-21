class VerifyPhoneController < ApplicationController
  before_action :find_verify_phone, only: [:edit, :update]

  def index
    redirect_to new_verify_phone_path
  end

  def new
    @verify_phone = VerifyPhone.new
    render :index
  end

  def create
    @verify_phone = VerifyPhone.find_or_initialize_by(phone_number: verify_phone_params[:phone_number])
    if @verify_phone.save
      verify_response = PhoneVerifier.new(phone_number: verify_phone_params[:phone_number]).send_verification_code
      if verify_response[:status] == 'success'
        @verify_phone.update(verification_code: verify_response[:code])
        redirect_to edit_verify_phone_path(@verify_phone), notice: "Phone verification code sent"
      else
        redirect_to new_verify_phone_path, alert: "There were some errors on verifying phone number"
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    render :index
  end

  def update
    if @verify_phone.verification_code == verify_phone_params[:verification_code]
      @verify_phone.update(is_verified: true)
      redirect_to new_verify_phone_path, notice: "Your phone number is verified"
    else
      redirect_to edit_verify_phone_path(@verify_phone), alert: "Verification code is not matched"
    end
  end

  private

  def find_verify_phone
    @verify_phone = VerifyPhone.find(params[:id])
  end

  def verify_phone_params
    params.require(:verify_phone).permit(:phone_number, :verification_code)
  end
end
