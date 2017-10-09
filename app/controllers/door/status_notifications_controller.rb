class Door::StatusNotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_client!

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

  def authorize_client!
    provided_token = params[:token] || ''
    required_token = Rails.application.secrets['door_notification_token']
    ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip

    unless ActiveSupport::SecurityUtils.secure_compare provided_token, required_token
      Rails.logger.warn "#{ip} is not authorized to perform this action (incorrect token)."
      head :unauthorized
    end
  end
end
