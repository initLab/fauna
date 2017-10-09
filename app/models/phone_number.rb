class PhoneNumber < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  validates :owner_id, presence: true
  validates :phone_number, phony_plausible: true, uniqueness: true, presence: true
  phony_normalize :phone_number, default_country_code: 'BG'
end
