module Fauna
  class UsersController < ApplicationController
    before_filter :authenticate_user!
    authorize_actions_for User

    def index
      @users = User.order(id: :desc).page params[:page]
    end
  end
end
