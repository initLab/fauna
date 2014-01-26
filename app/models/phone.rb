class Phone < Device
  validates :value, numericality: { only_integer: true }

  def value=(phone_number)
    write_attribute :value, phone_number.gsub(/\A0/, '')
  end
end
