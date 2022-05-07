module Door
  class CurrentStatus
    def door
      status['door'].to_sym
    end

    def latch
      status['latch'].to_sym
    end

    private

    def status
      begin
        Rails.cache.fetch('door_current_status', expires_in: cache_lifetime) do
          Rails.application.config.door_status_manager.backend.status
        end
      rescue StandardError => e
        Rails.logger.warn "Error retreiving door status: #{e}"
        {'door' => 'unknown', 'latch' => 'unknown'}
      end
    end

    def cache_lifetime
      Rails.application.config.door_status_manager.cache_lifetime
    end
  end
end
