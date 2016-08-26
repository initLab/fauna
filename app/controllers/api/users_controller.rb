class Api::UsersController < Api::ApplicationController
  def present
    @users = Presence.present_users
  end
end
