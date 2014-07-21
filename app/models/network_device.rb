class NetworkDevice < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'

  validates :owner_id, presence: true
  validates :mac_address, presence: true

  # TODO Add i18n
  validates :mac_address, format: { with: /\A[0-9A-F]{2}([:-]?)([0-9A-F]{2}\1){4}[0-9A-F]{2}\z/i, message: 'must be a mac address' }

  validates :mac_address, uniqueness: true

  before_save :normalize_mac_address!

  private

  def normalize_mac_address!
    self.mac_address = mac_address.downcase.gsub(/[:-]/, '').scan(/../).join(':')
  end
end
