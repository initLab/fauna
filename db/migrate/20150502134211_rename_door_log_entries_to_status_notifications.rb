class RenameDoorLogEntriesToStatusNotifications < ActiveRecord::Migration
  def change
    rename_table :door_log_entries, :door_status_notifications
  end
end
