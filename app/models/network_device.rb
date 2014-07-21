class NetworkDevice < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'userid'
  validates :userid, presence: true
  validates :value, presence: true

  validates :value, format: { with: /\A[0-9A-F]{12}\z/i, message: 'must be a mac address' }
  validates :value, uniqueness: true

  def value=(mac_address)
    write_attribute :value, mac_address.upcase.gsub(/[:-]/, '') if mac_address
  end

  def mac_address
    "#{value}".downcase.scan(/../).join(":")
  end
end
