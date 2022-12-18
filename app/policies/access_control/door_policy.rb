class AccessControl::DoorPolicy < ApplicationPolicy
  def open?
    record.permitted_roles_for(:open).any? { user.has_role?(_1) }
  end

  def lock?
    record.permitted_roles_for(:open).any? { user.has_role?(_1) }
  end

  def unlock?
    record.permitted_roles_for(:open).any? { user.has_role?(_1) }
  end
end
