class AddDescriptionToNetworkDevices < ActiveRecord::Migration
  def change
    add_column :network_devices, :description, :string
  end
end
