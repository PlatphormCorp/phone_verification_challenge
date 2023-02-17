class CreateVerificationCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :verification_codes do |t|
      t.string :code, index: true, null: false
      t.datetime :expires_at, null: false
      t.belongs_to :phone, index: true, foreign_key: true

      t.timestamps
    end
  end
end
