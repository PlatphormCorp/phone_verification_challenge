class VerifyPhoneController < ApplicationController
  def new
    @verify_phone = VerifyPhone.new
  end

  def create
    @verify_phone = VerifyPhone.find_or_initialize_by(number: verify_phone_params[:number])

    if @verify_phone.verified
      flash[:notice] = 'Phone number has already been verified.'
      return redirect_to root_path
    end

    if @verify_phone.save && SmsSender.new(@verify_phone).send_verification_code
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @verify_phone = VerifyPhone.find_by(number: verify_phone_params[:number])
  end

  def update
    @verify_phone = VerifyPhone.find_by(number: verify_phone_params[:number])

    if @verify_phone.validate_code(verify_phone_params[:verification_code])
      @verify_phone.update_attribute(:verified, true)
      flash[:notice] = 'Your phone number has been verified.'
      redirect_to new_verify_phone_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def verify_phone_params
    params.require(:verify_phone).permit(:number, :verification_code)
  end
end
