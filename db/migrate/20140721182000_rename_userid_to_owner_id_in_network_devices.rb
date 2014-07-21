class RenameUseridToOwnerIdInNetworkDevices < ActiveRecord::Migration
  def change
    rename_column :network_devices, :userid, :owner_id
  end
end
