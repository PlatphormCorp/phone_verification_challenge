class AddVerificationCodeToVerifyPhone < ActiveRecord::Migration[7.0]
  def change
    add_column :verify_phones, :verification_code, :integer
  end
end
