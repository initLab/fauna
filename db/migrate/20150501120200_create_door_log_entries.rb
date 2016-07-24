class CreateDoorLogEntries < ActiveRecord::Migration[4.2]
  def change
    create_table :door_log_entries do |t|
      t.string :door
      t.string :latch

      t.timestamps null: false
    end
  end
end
