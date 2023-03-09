class CreateVerifyPhones < ActiveRecord::Migration[7.0]
    def change
     create_table :verify_phones do |t|
       t.string :number, null: false, unique: true, index: true, length: 10
       t.string :verified, null: false, default: 'false'
       t.timestamps
     end
   end
end