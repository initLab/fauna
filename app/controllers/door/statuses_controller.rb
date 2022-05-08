class Door::StatusesController < ApplicationController
  before_action :authenticate_user!

  include DoorStatusHelper

  def show
    @current_status = door_status
  end

  def update
    @action = Door::Actions::Action.from_name status_params[:name]

    if @action.blank?
      return update_error('views.door_status.invalid_action')
    end

    authorize :door_manipulation

    @action.initiator = current_user
    @action.origin_information = "Remote Host: #{current_ip_address}"

    if @action.save
      update_success('views.door_status.action_executed_successfuly', action: @action)
      Rails.cache.delete('door_current_status')
    else
      update_error('views.door_status.action_executed_unsuccessfuly')
    end
  rescue Pundit::NotAuthorizedError
    update_error('views.door_status.forbidden')
  end

  private

  def update_error(message, args = {})
    flash[:error] = t(message, **args)
    redirect_back fallback_location: door_status_path
  end

  def update_success(message, args = {})
    flash[:notice] = t(message, **args)
    redirect_back fallback_location: door_status_path
  end

  def status_params
    params.require(:status).permit :name
  end
end
