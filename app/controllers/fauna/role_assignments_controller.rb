# frozen_string_literal: true
module Fauna
  class RoleAssignmentsController < ApplicationController
    before_action :authenticate_user!

    before_action :assign_user

    def index
      authorize :role_assignment
    end

    def new
      authorize :role_assignment
    end

    def create
      authorize :role_assignment
      role = Role.find(role_params[:role])
      start_time = role_params[:start_time]
      end_time = role_params[:end_time]

      respond_to do |format|
        format.html do
          if @user.add_role(role, start_time, end_time)
            redirect_to fauna_user_role_assignments_path
          else
            render :new, status: :unprocessable_content
          end
        end

        format.js do
          if @user.add_role(role, start_time, end_time)
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
      role = Role.find(params[:id])
      start_time = params[:start_time]

      respond_to do |format|
        format.html do
          if @user.remove_role(role, start_time)
            redirect_to fauna_user_role_assignments_path
          else
            redirect_back fallback_location: fauna_user_role_assignments_path, status: :unprocessable_entity
          end
        end
        format.js do
          if @user.remove_role(role, start_time)
            render :refresh
          else
            head :unprocessable_entity
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
      params.require(:user_role).permit(%i[role start_time end_time])
    end
  end
end
