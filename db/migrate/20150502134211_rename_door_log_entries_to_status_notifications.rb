class RenameDoorLogEntriesToStatusNotifications < ActiveRecord::Migration[4.2]
  def change
    rename_table :door_log_entries, :door_status_notifications
  end
end
