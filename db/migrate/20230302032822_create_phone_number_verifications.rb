class CreatePhoneNumberVerifications < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_number_verifications do |t|
      t.string :token
      t.references :phone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
