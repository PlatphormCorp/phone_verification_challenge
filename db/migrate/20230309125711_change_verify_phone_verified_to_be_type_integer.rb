class ChangeVerifyPhoneVerifiedToBeTypeInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :verify_phones, :verified
    add_column :verify_phones, :status, :integer, default: 0
  end
end
