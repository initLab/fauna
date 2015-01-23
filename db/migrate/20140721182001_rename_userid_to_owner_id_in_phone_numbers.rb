class RenameUseridToOwnerIdInPhoneNumbers < ActiveRecord::Migration
  def change
    rename_column :phone_numbers, :userid, :owner_id
  end
end
