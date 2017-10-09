class RenameUseridToOwnerIdInPhoneNumbers < ActiveRecord::Migration[4.2]
  def change
    rename_column :phone_numbers, :userid, :owner_id
  end
end
