class CreateVerificationCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :verification_codes do |t|
      t.integer :code
      t.datetime :expires_at
      t.references :phone_number, null: false, foreign_key: true

      t.timestamps
    end
  end
end
