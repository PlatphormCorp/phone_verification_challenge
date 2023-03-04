class RenamePhoneNumbersToVerifyPhones < ActiveRecord::Migration[7.0]
  def change
    rename_table :phone_numbers, :verify_phones
  end
end
