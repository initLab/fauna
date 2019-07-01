class NegateUserAnnounceMyPresence < ActiveRecord::Migration[5.2]
  def up
    execute "UPDATE users SET announce_my_presence = NOT announce_my_presence;"
  end
  
  def down
    execute "UPDATE users SET announce_my_presence = NOT announce_my_presence;"
  end
end
