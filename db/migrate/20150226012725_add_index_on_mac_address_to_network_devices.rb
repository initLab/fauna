class AddIndexOnMacAddressToNetworkDevices < ActiveRecord::Migration[4.2]
  def change
    add_index :network_devices, :mac_address
  end
end
