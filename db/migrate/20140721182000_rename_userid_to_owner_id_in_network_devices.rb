class RenameUseridToOwnerIdInNetworkDevices < ActiveRecord::Migration[4.2]
  def change
    rename_column :network_devices, :userid, :owner_id
  end
end
