class Role < ApplicationRecord
  PREDEFINED_ROLES = %i[board_member trusted_member member infra tenant landlord].freeze

  has_many :user_roles
  has_many :users, through: :user_roles

  validates :name, inclusion: {in: Role::PREDEFINED_ROLES.map(&:to_s)}

  def localized_name
    I18n.t "roles.#{name}"
  end

  def self.predefined
    PREDEFINED_ROLES.map { |name| Role.find_or_initialize_by name: name }
  end
end
