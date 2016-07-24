class RenameObjectsToNetworkDevices < ActiveRecord::Migration[4.2]
  def change
    rename_table :objects, :network_devices
  end
end
