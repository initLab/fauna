class Api::UsersController < Api::ApplicationController
  wrap_parameters format: [:json]
  include Api::PublicApiExposingController

  def present
    @users = Presence.present_users
  end
end
