class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource) || if resource.is_a?(User)
      edit_user_registration_path
    else
      super
    end
  end
end
