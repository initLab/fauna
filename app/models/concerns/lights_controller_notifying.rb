module LightsControllerNotifying
  extend ActiveSupport::Concern

  included do
    after_create :notify_lights_controller
  end

  private

  def notify_lights_controller
    Lights::StatusManager::notify_controller!
  end
end
