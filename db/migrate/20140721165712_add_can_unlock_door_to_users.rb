class AddCanUnlockDoorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :can_unlock_door, :boolean, default: false, null: false
  end
end
