class DoorManipulationPolicy < ApplicationPolicy
  def create?
    return false unless user.present?

    user.has_role?(:trusted_member) or user.has_role?(:board_member)
  end

  def update?
    create?
  end
end
