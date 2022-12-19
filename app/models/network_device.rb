class NetworkDevice < ApplicationRecord
  belongs_to :owner, class_name: "User"

  validates :owner_id, presence: true
  validates :mac_address, presence: true

  validates :mac_address, format: {with: /\A[0-9A-F]{2}([:-]?)([0-9A-F]{2}\1){4}[0-9A-F]{2}\z/i}

  validates :mac_address, uniqueness: true

  before_save :normalize_mac_address!

  private

  def normalize_mac_address!
    self.mac_address = mac_address.downcase.gsub(/[:-]/, "").scan(/../).join(":")
  end
end
