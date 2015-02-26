class AddIndexOnMacAddressToNetworkDevices < ActiveRecord::Migration
  def change
    add_index :network_devices, :mac_address
  end
end
