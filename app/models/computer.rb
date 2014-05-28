class Computer < Device
  validates :value, format: { with: /\A[0-9A-F]{2}([:-]?)([0-9A-F]{2}\1){4}[0-9A-F]{2}\z/i, message: 'must be a mac address' }

  def self.sti_name
    'mac'
  end

  def value=(mac_address)
    write_attribute :value, mac_address.upcase.gsub(/[:-]/, '') if mac_address.present?
  end

  def mac_address
    value.downcase.scan(/../).join(":")
  end
end
