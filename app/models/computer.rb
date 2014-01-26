class Computer < Device
  validates :value, format: { with: /\A[0-9A-F]{2}([:-]?)([0-9A-F]{2}\1){4}[0-9A-F]{2}\z/i, message: 'must be a mac address' }

  def value=(mac_address)
    write_attribute :value, mac_address.upcase.gsub(/[:-]/, '')
  end
end
