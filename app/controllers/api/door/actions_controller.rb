class Api::Door::ActionsController < Api::ApplicationController
  before_action do
    doorkeeper_authorize! :door_handle_control
    doorkeeper_authorize! :door_latch_control
  end

  def create
    @action = ::Door::Actions::Action.from_name door_action_params[:name]

    if @action.blank?
      return head :unprocessable_entity
    end

    authorize :door_manipulation

    @action.initiator = current_resource_owner
    @action.origin_information = "Remote Host: #{current_ip_address}"

    if @action.save
      head :no_content
      Rails.cache.delete('door_current_status')
    else
      head :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError
    head :forbidden
  end

  def door_action_params
    params.require(:door_action).permit :name
  end
end
