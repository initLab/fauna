module Fauna
  class RoleAssignmentsController < ApplicationController
    before_filter :authenticate_user!
    authorize_actions_for User

    before_action :assign_user

    def create
      respond_to do |format|
        format.js do
          if @user.add_role(role_params[:name]).persisted?
            render :refresh, status: :created
          else
            head :unprocessable_entity
          end
        end
      end
    end

    def destroy
      respond_to do |format|
        format.js do
          unless @user.remove_role(params[:role_name]).empty?
            render :refresh
          else
            head :unprocessable_entity
          end
        end
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
