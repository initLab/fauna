class AccessControl::DoorControllers::Dummy
  def call(action)
    Rails.logger.error("Dummy controller performed action: #{action}")
  end
end
