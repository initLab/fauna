class Role < ApplicationRecord
  PREDEFINED_ROLES = [:board_member, :trusted_member, :member, :'3d'].freeze

  has_and_belongs_to_many :users, join_table: :users_roles
  belongs_to :resource, polymorphic: true, optional: true

  validates :resource_type,
            inclusion: {in: Rolify.resource_types},
            allow_nil: true

  validates :name, inclusion: {in: Role::PREDEFINED_ROLES.map(&:to_s)}

  def localized_name
    I18n.t "roles.#{name}"
  end

  def self.predefined
    PREDEFINED_ROLES.map { |name| Role.find_or_initialize_by name: name }
  end

  scopify
end
