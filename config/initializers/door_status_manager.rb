# Pesho instance for door status updates
Rails.application.config.door_status_manager = ActiveSupport::OrderedOptions.new
Rails.application.config.door_status_manager.host = 'http://192.168.232.2'
Rails.application.config.door_status_manager.timeout = 1
Rails.application.config.door_status_manager.cache_lifetime = 1.minute
Rails.application.config.door_status_manager.backend = DoorStatusManager::Pesho.new
