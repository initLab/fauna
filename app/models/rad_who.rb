class RadWho
  MAC_REGEXP = /(?<mac>[0-9A-F]{2}(?<separator>[:-]?)([0-9A-F]{2}\k<separator>){4}[0-9A-F]{2})/i.freeze
  RAW_ENTRY_REGEXP = /^.*?-#{MAC_REGEXP},(?<session>.*?),.*$/i.freeze
  TRANSFORMED_ENTRY_REGEXP = /\A(?<session>.*?)-#{MAC_REGEXP}\z/i.freeze

  def initialize
    @radwho_output = RadWho.radwho
  end

  def self.radwho
    (`radwho -i -r -F /var/log/freeradius/radutmp ` || "").gsub(RAW_ENTRY_REGEXP, '\k<session>-\k<mac>')
  end

  def mac_addresses
    @mac_addresses ||= sessions.keys
  end

  def sessions
    @sessions = valid_radwho_entries.map do |entry|
      entry.scan TRANSFORMED_ENTRY_REGEXP
      [$1, normalize_mac_address($2)]
    end.group_by(&:last).map do |mac, sessions|
      [mac, sessions.map(&:first)]
    end.to_h
  end

  def present_users
    present_known_and_visible_users + present_unknown_users
  end

  def present_unknown_users
    unknown_mac_addresses.map do |mac_address|
      User.new email: email_for_unknown_user(mac_address),
               username: 'mystery_user',
               name: 'Mystery Labber'
    end
  end

  def present_known_and_visible_users
    present_known_users.where(privacy: false)
  end

  private

  def valid_radwho_entries
    @valid_radwho_entries ||= @radwho_output.split(/\n/).select do |entry|
      entry =~ TRANSFORMED_ENTRY_REGEXP
    end
  end

  def email_for_unknown_user(mac_address)
    (sessions[mac_address].first || ('a'..'z').to_a.shuffle[0,8].join) + '@example.com'
  end

  def present_known_users
    User.joins(:network_devices).where(network_devices: {id: present_known_devices.where(use_for_presence: true)}).uniq
  end

  def present_known_devices
    NetworkDevice.where mac_address: mac_addresses
  end

  def unknown_mac_addresses
    mac_addresses - present_known_devices.joins(:owner).where(users: {privacy: false}).pluck(:mac_address)
  end

  def normalize_mac_address(mac_address)
    mac_address.downcase.gsub(/[:-]/, '').scan(/../).join(':')
  end
end
