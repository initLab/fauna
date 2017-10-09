class Api::Door::ActionsController < Api::ApplicationController
  before_action :authenticate_user!

  def create
    @action = ::Door::Actions::Action.from_name door_action_params[:name]

    if @action.blank?
      return head :unprocessable_entity
    end

    if not @action.creatable_by? current_user
      return head :forbidden
    end

    @action.initiator = current_user
    @action.origin_information = "Remote Host: #{current_ip_address}"

    if @action.save
      head :no_content
      Rails.cache.delete('door_current_status')
    else
      head :unprocessable_entity
    end
  end

  def door_action_params
    params.require(:door_action).permit :name
  end
end
