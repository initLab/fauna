class Arp
  def self.all
    # Make sure you set the following sysctl knobs to something sane or else
    # your users will stay present forever:
    # net.ipv4.neigh.default.gc_thresh1 = 10
    # net.ipv6.neigh.default.gc_thresh1 = 20
    `ip neigh show nud reachable nud stale`.split(/\n/).map do |entry|
      addresses = *entry.scan(/\A([0-9a-f:.]*?) dev ([a-z0-9.\-]*?) lladdr ([0-9a-f:].*?) .*\z/i).first
      Arp.new(*addresses)
    end.compact
  end

  def self.present_users
    User.joins(:network_devices)
        .where(announce_my_presence: true)
        .where(network_devices: {
                 mac_address: all.map(&:mac_address),
                 use_for_presence: true
        }).distinct
  end

  def self.mac_by_ip_address(ip_address)
    matching_entry = all.select { |entry| entry.ip_address == ip_address }.first
    matching_entry.mac_address if matching_entry.present?
  end

  attr_reader :mac_address, :ip_address, :interface

  def initialize(ip_address, interface, mac_address)
    @mac_address = mac_address.downcase.gsub(/[:-]/, '').scan(/../).join(':')
    @ip_address = ip_address
    @interface = interface
  end
end
