class RemoveTypeFromNetworkDevices < ActiveRecord::Migration
  def change
    remove_column :network_devices, :type, :string
  end
end
