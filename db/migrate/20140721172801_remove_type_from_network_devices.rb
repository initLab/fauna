class RemoveTypeFromNetworkDevices < ActiveRecord::Migration[4.2]
  def change
    remove_column :network_devices, :type, :string
  end
end
