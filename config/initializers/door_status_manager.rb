# Pesho instance for door status updates
Rails.application.config.door_status_manager.host = '[::1]'
Rails.application.config.door_status_manager.url = "http://#{Rails.application.config.door_status_manager.host}"
Rails.application.config.door_status_manager.timeout = 1
Rails.application.config.door_status_manager.cache_lifetime = 1.minute
Rails.application.config.door_status_manager.backend = Rails.application.config.door_status_manager_backend.new
