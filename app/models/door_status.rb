class DoorStatus
  def door
    status['door'].to_sym
  end

  def latch
    status['latch'].to_sym
  end

  private

  def status
    begin
      Rails.application.config.door_status_manager_backend.status
    rescue DoorStatusManager::Error
      Rails.logger.warn 'Error retreiving door status.'
      {'door' => 'unknown', 'latch' => 'unknown'}
    end
  end
end
