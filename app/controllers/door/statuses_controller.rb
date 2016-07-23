class Door::StatusesController < ApplicationController
  before_filter :authenticate_user!

  include DoorStatusHelper

  def show
    @current_status = door_status
  end

  def update
    @action = Door::Actions::Action.from_name status_params[:name]

    if @action.blank?
      return update_error('views.door_status.invalid_action')
    end

    if not @action.creatable_by? current_user
      return update_error('views.door_status.forbidden')
    end

    @action.initiator = current_user
    @action.origin_information = "Remote Host: #{current_ip_address}"

    if @action.save
      update_success('views.door_status.action_executed_successfuly', action: @action)
      Rails.cache.delete('door_current_status')
    else
      update_error('views.door_status.action_executed_unsuccessfuly')
    end
  end

  private

  def update_error(message, args = {})
    flash[:error] = I18n.t(message, args)
    redirect_to :back
  end

  def update_success(message, args = {})
    flash[:notice] = I18n.t(message, args)
    redirect_to :back
  end

  def status_params
    params.require(:status).permit :name
  end
end
