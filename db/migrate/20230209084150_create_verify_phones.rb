class CreateVerifyPhones < ActiveRecord::Migration[7.0]
  def change
    create_table :verify_phones do |t|
      t.string :phone_number
      t.string :verification_code
      t.boolean :is_verified
      t.timestamps
    end
  end
end
