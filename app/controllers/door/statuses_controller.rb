class Door::StatusesController < ApplicationController
  before_filter :authenticate_user!

  include DoorStatusHelper

  def show
    @current_status = door_status
  end

  def update
    @action = Door::Actions::Action.from_name status_params[:name]

    if @action.present?
      if @action.creatable_by? current_user
        if @action.save
          flash[:notice] = I18n.t('views.door_status.action_executed_successfuly', action: @action)
          Rails.cache.delete('door_current_status')
        else
          flash[:error] = I18n.t('views.door_status.action_executed_unsuccessfuly')
        end
      else
        flash[:error] = I18n.t('views.door_status.forbidden')
      end
    else
      flash[:error] = I18n.t('views.door_status.invalid_action')
    end

    redirect_to :back
  end

  private

  def status_params
    params.require(:status).permit :name
  end
end
