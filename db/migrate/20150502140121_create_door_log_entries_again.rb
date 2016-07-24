class CreateDoorLogEntriesAgain < ActiveRecord::Migration[4.2]
  def change
    create_table :door_log_entries do |t|
      t.references :loggable, polymorphic: true
    end
  end
end
