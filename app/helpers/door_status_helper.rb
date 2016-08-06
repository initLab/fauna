module DoorStatusHelper
  def door_status
    Rails.cache.fetch('door_current_status',
                      expires_in: Rails.application.config.door_status_manager.cache_lifetime) do
      Door::CurrentStatus.new.latch
    end
  end
end
