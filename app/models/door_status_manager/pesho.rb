module DoorStatusManager
  class Pesho
    include HTTParty

    def initialize
      self.class.base_uri Rails.application.config.door_status_manager.host
    end

    def status
      self.class.get("/status", query: {key: key}, timeout: 1)
    end

    private

    def key
      Rails.application.secrets['door_status_manager_key']
    end
  end
end
