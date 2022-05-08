module Fauna
  class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
      @users = User.order(id: :desc).page params[:page]
      authorize @users
    rescue Pundit::NotAuthorizedError
      head :forbidden
    end
  end
end
