class RenameObjectsToNetworkDevices < ActiveRecord::Migration
  def change
    rename_table :objects, :network_devices
  end
end
