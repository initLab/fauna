class Phone < Device
  validates :value, numericality: {only_integer: true}
  validates :value, length: {in: 9..10}
  validates :value, uniqueness: true

  def self.sti_name
    'phone'
  end

  def value=(phone_number)
    write_attribute :value, phone_number.gsub(/\A0/, '') if phone_number
  end

  def number
    if value.present?
      value.prepend('0')
    else
      ""
    end
  end

  def separated_number
    number.scan(/\A([0-9]{3})([0-9]{3})(.*)/).join(" ")
  end
end
