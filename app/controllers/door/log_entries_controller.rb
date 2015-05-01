class Door::LogEntriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authorize_client!

  def create
    @log_entry = Door::LogEntry.new log_entry_params

    if @log_entry.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def log_entry_params
    params.permit :door, :latch
  end

  # TODO: Move to token-based authentication when there is support for it in
  # Pesho
  def authorize_client!
    ip = request.remote_ip

    unless ip == Rails.application.config.door_status_manager.host
      Rails.logger.warn "#{ip} is not authorized to perform this action."
      head :unauthorized
    end
  end
end
