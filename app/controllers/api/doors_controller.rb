class Api::DoorsController < Api::ApplicationController
  before_action :authorize_scope, :assign_door, :authorize_action, :append_audit_log_entry, except: [:index]

  def index
    doorkeeper_authorize! :account_data_read

    @doors = AccessControl::Door.all
  end

  def open
    perform_door_action :open
  end

  def lock
    perform_door_action :lock
  end

  def unlock
    perform_door_action :unlock
  end

  private

  def assign_door
    @door = AccessControl::Door.find(params[:door_id])
  end

  def authorize_scope
    doorkeeper_authorize! :door_control
  end

  def authorize_action
    authorize @door
  end

  def perform_door_action(action)
    @door.perform_action(action)
    head :no_content
  end

  def append_audit_log_entry
    AuditLog::ControllerAction.create!(user: current_resource_owner, payload: {parameters: params, host: request.remote_ip})
  end
end
