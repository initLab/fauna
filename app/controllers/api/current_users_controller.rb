class Api::CurrentUsersController < Api::ApplicationController
  before_action :authenticate_user!

  def show
    @current_user = current_user
  end
end
