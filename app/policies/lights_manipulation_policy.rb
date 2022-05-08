class LightsManipulationPolicy < ApplicationPolicy
  def create?
    super || user&.has_role?(:trusted_member)
  end

  def update?
    create?
  end

  def show?
    create?
  end
end
