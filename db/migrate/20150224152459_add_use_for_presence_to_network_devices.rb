class AddUseForPresenceToNetworkDevices < ActiveRecord::Migration
  def change
    add_column :network_devices, :use_for_presence, :boolean, null: false, default: true
  end
end
