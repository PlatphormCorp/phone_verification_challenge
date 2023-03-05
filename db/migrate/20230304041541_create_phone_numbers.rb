class CreatePhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_numbers do |t|
      t.integer :number, null: false
      t.string :verification_code
      t.boolean :verified, default: false

      t.timestamps
    end
  end
end
