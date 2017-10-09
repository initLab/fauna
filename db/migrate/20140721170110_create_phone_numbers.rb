class CreatePhoneNumbers < ActiveRecord::Migration[4.2]
  def change
    create_table :phone_numbers do |t|
      t.integer :userid, index: true, null: false
      t.string :type
      t.string :value

      t.timestamps null: false
    end
  end
end
