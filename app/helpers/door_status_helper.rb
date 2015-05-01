module DoorStatusHelper
  def door_status
    Rails.cache.fetch('door_status', expires_in: Rails.application.config.door_status_manager.cache_lifetime) do
      DoorStatus.new.latch
    end
  end
end
