class Door::StatusNotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authorize_client!

  def create
    @status_notification = Door::StatusNotification.new status_notification_params

    if @status_notification.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def status_notification_params
    params.permit :door, :latch
  end

  # TODO: Move to token-based authentication when there is support for it in
  # Pesho
  def authorize_client!
    ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip

    unless ip == Rails.application.config.door_status_manager.host
      Rails.logger.warn "#{ip} is not authorized to perform this action."
      head :unauthorized
    end
  end
end
