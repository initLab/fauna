class UsersController < ApplicationController
  def present
    @users = Arp.present_users
  end
end
