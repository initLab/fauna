class CreateDevices < ActiveRecord::Migration
  def change
    create_table :objects do |t|
      t.integer :userid, index: true, null: false
      t.string :type
      t.string :value

      t.timestamps null: false
    end
  end
end
