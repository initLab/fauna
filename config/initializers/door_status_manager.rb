# Pesho instance for door status updates
Rails.application.config.door_status_manager = ActiveSupport::OrderedOptions.new
Rails.application.config.door_status_manager.backend = DoorStatusManager::Pesho
Rails.application.config.door_status_manager.host = 'http://192.168.232.2'
Rails.application.config.door_status_manager.timeout = 1
