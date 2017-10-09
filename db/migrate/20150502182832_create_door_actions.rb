class CreateDoorActions < ActiveRecord::Migration[4.2]
  def change
    create_table :door_actions do |t|
      t.string :type
      t.references :initiator, index: true
      t.text :origin_information

      t.timestamps null: false
    end

    add_index :door_actions, :type
  end
end
