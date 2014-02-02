class Arp
  def self.all
    `ip neigh show`.split(/\n/).map do |entry|
      Arp.new *entry.scan(/\A([0-9a-f:.]*?) dev ([a-z0-9]*?) lladdr ([0-9a-f:].*?) .*\z/i).first
    end
  end

  def self.present_users
    all.map(&:owner).uniq
  end

  def self.mac_by_ip_address(ip_address)
    matching_entry = all.select { |entry| entry.ip_address == ip_address }.first
    matching_entry.mac_address if matching_entry.present?
  end

  attr_reader :mac_address, :ip_address, :interface

  def initialize(ip_address, interface, mac_address)
    @mac_address = mac_address.upcase.gsub(/[:-]/, '')
    @ip_address = ip_address
    @interface = interface
  end

  def owner
    Computer.find_or_initialize_by(value: @mac_address).owner
  end
end
