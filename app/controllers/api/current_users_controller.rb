class Api::CurrentUsersController < Api::ApplicationController
  before_action -> { doorkeeper_authorize! :account_data_read }

  def show
    @current_user = current_resource_owner
  end
end
