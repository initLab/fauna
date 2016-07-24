class RenameValueToMacAddressInNetworkDevices < ActiveRecord::Migration[4.2]
  def change
    rename_column :network_devices, :value, :mac_address
  end
end
