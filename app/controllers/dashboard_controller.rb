class DashboardController < ApplicationController
  def index
    @users = Presence.present_users
  end
end
