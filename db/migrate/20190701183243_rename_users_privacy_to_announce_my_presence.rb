class RenameUsersPrivacyToAnnounceMyPresence < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :privacy, :announce_my_presence
  end
end
