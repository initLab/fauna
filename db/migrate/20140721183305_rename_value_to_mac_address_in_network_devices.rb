class RenameValueToMacAddressInNetworkDevices < ActiveRecord::Migration
  def change
    rename_column :network_devices, :value, :mac_address
  end
end
