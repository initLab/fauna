class AddUseForPresenceToNetworkDevices < ActiveRecord::Migration[4.2]
  def change
    add_column :network_devices, :use_for_presence, :boolean, null: false, default: true
  end
end
