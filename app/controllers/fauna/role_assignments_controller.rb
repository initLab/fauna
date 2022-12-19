module Fauna
  class RoleAssignmentsController < ApplicationController
    before_action :authenticate_user!

    before_action :assign_user

    def create
      authorize :role_assignment

      respond_to do |format|
        format.js do
          if @user.add_role(role_params[:name]).persisted?
            render :refresh, status: :created
          else
            head :unprocessable_entity
          end
        end
      end
    rescue Pundit::NotAuthorizedError
      head :forbidden
    end

    def destroy
      authorize :role_assignment

      respond_to do |format|
        format.js do
          if @user.remove_role(params[:role_name]).empty?
            head :unprocessable_entity
          else
            render :refresh
          end
        end
      end
    rescue Pundit::NotAuthorizedError
      head :forbidden
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
