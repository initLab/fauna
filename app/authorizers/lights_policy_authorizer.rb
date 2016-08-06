class LightsPolicyAuthorizer < ApplicationAuthorizer
  def self.updatable_by?(user)
    user.has_role?(:trusted_member) or user.has_role?(:board_member)
  end

  def self.readable_by?(user)
    updatable_by? user
  end
end
