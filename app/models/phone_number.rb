class PhoneNumber < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'

  validates :owner_id, presence: true
  validates :phone_number, uniqueness: true, presence: true, numericality: { only_integer: true }
  phony_normalize :phone_number, default_country_code: 'BG'
end
