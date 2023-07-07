class UsersController < ApplicationController
  before_action :set_access_control_headers, only: :present

  def present
    @users = Presence.present_users
  end

  private

  def set_access_control_headers
    if request.format.json?
      response.headers["Access-Control-Allow-Origin"] = "*"
    end
  end
end
