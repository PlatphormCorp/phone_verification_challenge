class CreateVerifyPhones < ActiveRecord::Migration[7.0]
  def change
    create_table :verify_phones do |t|
      t.string :phone_number
      t.string :verification_code
      t.timestamp :verified_at
      t.timestamp :number_verified_confirmed_at

      t.timestamps
    end
  end
end
