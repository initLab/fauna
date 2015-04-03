module Fauna
  class RoleAssignmentsController < ApplicationController
    before_filter :authenticate_user!
    authorize_actions_for User

    before_action :assign_user

    def create
      if @user.add_role(role_params[:name]).persisted?
        head :created
      else
        head :unprocessable_entity
      end
    end

    def destroy
      unless @user.remove_role(params[:role_name]).empty?
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    private

    def assign_user
      @user = User.find params[:user_id]
    end

    def role_params
      params.require(:role).permit(:name)
    end
  end
end
