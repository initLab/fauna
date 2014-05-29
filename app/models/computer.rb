class Computer < Device
  validates :value, format: { with: /\A[0-9A-F]{12}\z/i, message: 'must be a mac address' }
  validates :value, uniqueness: true

  def self.sti_name
    'mac'
  end

  def value=(mac_address)
    write_attribute :value, mac_address.upcase.gsub(/[:-]/, '') if mac_address
  end

  def mac_address
    "#{value}".downcase.scan(/../).join(":")
  end
end
