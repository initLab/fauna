class Api::UsersController < Api::ApplicationController
  include Api::PublicApiExposingController

  def present
    @users = Presence.present_users
  end
end
