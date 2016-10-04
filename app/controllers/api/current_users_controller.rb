class Api::CurrentUsersController < Api::ApplicationController
  before_filter :authenticate_user!
  
  def show
    @current_user = current_user
  end
end
