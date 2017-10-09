class AddCanUnlockDoorToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :can_unlock_door, :boolean, default: false, null: false
  end
end
