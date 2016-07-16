class RadWho
  attr_reader :mac_address

  def initialize
    @radwho_output = RadWho.radwho
  end

  def self.radwho
    `radwho -i -r -F /var/log/freeradius/radutmp `.gsub(/.*?-(.*?),(.*?),.*/, '\2-\1')
  end

  def mac_addresses
    @mac_addresses ||= @radwho_output.split(/\n/).map do |entry|
      entry.scan(/\A.*?-([0-9A-F]{2}([:-]?)([0-9A-F]{2}\2){4}[0-9A-F]{2})\z/i)
      $1
    end.compact.uniq.map { |entry| entry.downcase.gsub(/[:-]/, '').scan(/../).join(':') }
  end

  def sessions
    @sessions ||= @radwho_output.split(/\n/).map do |entry|
      entry.scan(/\A(.*?)-([0-9A-F]{2}([:-]?)([0-9A-F]{2}\3){4}[0-9A-F]{2})\z/i)
      [$1, $2]
    end.compact.map { |session, mac| [session, mac.downcase.gsub(/[:-]/, '').scan(/../).join(':')] }.group_by(&:last).map do |mac, sessions|
      [mac, sessions.map(&:first)]
    end.to_h
  end

  def present_users
    present_known_and_visible_users + present_unknown_users
  end

  def present_unknown_users
    unknown_mac_addresses.map do |mac_address|
      User.new email: (sessions[mac_address].first || ('a'..'z').to_a.shuffle[0,8].join) + '@example.com', username: 'mystery_user', name: 'Mystery Labber'
    end
  end

  def present_known_and_visible_users
    present_known_users.where(privacy: false)
  end

  private

  def present_known_users
    User.joins(:network_devices).where(network_devices: {id: present_known_devices.where(use_for_presence: true)}).uniq
  end

  def present_known_devices
    NetworkDevice.where mac_address: mac_addresses
  end

  def unknown_mac_addresses
    mac_addresses - present_known_devices.joins(:owner).where(users: {privacy: false}).pluck(:mac_address)
  end
end
