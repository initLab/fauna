class ReformatMacAddressesInNetworkDevices < ActiveRecord::Migration
  def up
    NetworkDevice.all.map(&:save)
  end
end
