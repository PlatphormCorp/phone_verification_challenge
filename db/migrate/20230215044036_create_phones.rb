class CreatePhones < ActiveRecord::Migration[7.0]
  def change
    create_table :phones do |t|
      t.string :number, index: true, null: false
      t.datetime :verification_expiration

      t.timestamps
    end
  end
end
