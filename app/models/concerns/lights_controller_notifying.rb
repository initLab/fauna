module LightsControllerNotifying
  extend ActiveSupport::Concern

  included do
    after_create :notify_lights_controller
  end

  private

  # TODO: Remove this in favour of websocket notifications
  def notify_lights_controller
    Rails.application.config.lights_policy_manager.notify_controller!
  end
end
