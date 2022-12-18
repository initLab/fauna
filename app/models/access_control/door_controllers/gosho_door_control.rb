class AccessControl::DoorControllers::GoshoDoorControl
  def initialize(host:, port:, username:, password:)
    @host, @port, @username, @password = host, port, username, password
  end

  def open
    Rails.logger.error("Open")
  end

  def unlock
    Rails.logger.error("Unlock")
  end

  def lock
    Rails.logger.error("Lock")
  end
end
