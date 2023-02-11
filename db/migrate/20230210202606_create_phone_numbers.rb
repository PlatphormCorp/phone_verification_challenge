class CreatePhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_numbers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :phone_type
      t.string :number
      t.boolean :validated

      t.timestamps
    end
  end
end
