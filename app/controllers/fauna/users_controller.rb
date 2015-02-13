module Fauna
  class UsersController < ApplicationController
    # TODO: Add authentication and authorization
    def index
      @users = User.order(id: :desc).page(params[:page]).per(5)
    end
  end
end
