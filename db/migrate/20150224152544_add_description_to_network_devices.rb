class AddDescriptionToNetworkDevices < ActiveRecord::Migration[4.2]
  def change
    add_column :network_devices, :description, :string
  end
end
