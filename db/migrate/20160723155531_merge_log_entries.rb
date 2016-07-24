class MergeLogEntries < ActiveRecord::Migration[4.2]
  class DoorLogEntry < ActiveRecord::Base
  end

  def up
    create_table :log_entries do |t|
      t.integer :loggable_id, null: false
      t.string :loggable_type, null: false

      t.timestamps null: false
    end

    DoorLogEntry.find_each do |log_entry|
      LogEntry.create!({
        loggable_id:   log_entry.loggable_id,
        loggable_type: log_entry.loggable_type,
      })
    end

    drop_table :door_log_entries
    drop_table :lights_log_entries
  end

  def down
    create_table :door_log_entries do |t|
      t.integer :loggable_id
      t.string :loggable_type
    end

    create_table :lights_log_entries do |t|
      t.integer :loggable_id
      t.string :loggable_type
      t.timestamps null: false
    end

    LogEntry.find_each do |log_entry|
      DoorLogEntry.create!({
        loggable_id:   log_entry.loggable_id,
        loggable_type: log_entry.loggable_type,
      })
    end

    drop_table :log_entries
  end
end
