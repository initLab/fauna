class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  private

  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present?
  end

  protected

  def after_sign_up_path_for(resource)
    stored_location_for(resource) || if resource.is_a?(User)
      edit_user_registration_path
    else
      super
    end
  end

  def after_update_path_for(resource)
    if resource.is_a?(User)
      edit_user_registration_path
    else
      super
    end
  end
end
