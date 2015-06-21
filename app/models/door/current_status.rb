class Door::CurrentStatus
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
    rescue StandardError => e
      Rails.logger.warn "Error retreiving door status: #{e}"
      {'door' => 'unknown', 'latch' => 'unknown'}
    end
  end
end
