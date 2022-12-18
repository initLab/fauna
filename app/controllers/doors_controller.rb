class DoorsController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_door, :authorize_action, :append_audit_log_entry, except: [:index]

  def index
    @doors = AccessControl::Door.all
  end

  def open
    perform_door_action(:open)
  end

  def lock
    perform_door_action(:lock)
  end

  def unlock
    perform_door_action(:unlock)
  end

  private

  def assign_door
    @door = AccessControl::Door.find(params[:door_id])
  end

  def authorize_action
    authorize @door
  end

  def perform_door_action(action)
    @door.perform_action(action)

    flash.notice = I18n.t("views.doors.action_executed_successfully")
  rescue
    flash.error = I18n.t("views.doors.action_executed_unsuccessfully")
  ensure
    redirect_back_or_to({action: :index})
  end

  def append_audit_log_entry
    AuditLog::ControllerAction.create!(user: current_user, payload: {parameters: params, host: request.remote_ip})
  end
end
