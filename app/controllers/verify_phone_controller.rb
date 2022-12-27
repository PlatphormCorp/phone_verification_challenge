class VerifyPhoneController < ApplicationController
  before_action :find_verify_phone, only: [:edit, :update]
  def index
    redirect_to new_verify_phone_path
  end

  def new
    @verify_phone = VerifyPhone.new
    render 'verify_phone/index'
  end

  def edit
    render 'verify_phone/index', status: :ok
  end

  def update
    sms_service = SmsService.new
    result = sms_service.verify_code_for_phone_number(@verify_phone, verify_phone_params[:verification_code_confirmation])
    if result
      redirect_to edit_verify_phone_path(id: @verify_phone.id)
    else
      render 'verify_phone/index', status: :unprocessable_entity
    end
  end

  def create
    @verify_phone = VerifyPhone.find_or_initialize_by(phone_number: verify_phone_params[:phone_number])

    if @verify_phone.save
      sms_service = SmsService.new
      sms_service.generate_and_send_code(@verify_phone)
      redirect_to edit_verify_phone_path(id: @verify_phone.id)
    else
      render 'verify_phone/index', status: :unprocessable_entity
    end

  end

  private

  def verify_phone_params
    params.require(:verify_phone).permit(
      :phone_number,
      :verification_code_confirmation,
    )
  end

  def find_verify_phone
    @verify_phone = VerifyPhone.find_by!(id: params[:id])
  end
end