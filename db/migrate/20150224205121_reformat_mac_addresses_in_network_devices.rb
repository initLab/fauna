class ReformatMacAddressesInNetworkDevices < ActiveRecord::Migration[4.2]
  def up
    NetworkDevice.all.map(&:save)
  end
end
