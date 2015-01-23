class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.integer :userid, index: true, null: false
      t.string :type
      t.string :value

      t.timestamps
    end
  end
end
