class Lights::PolicyManager::InitLab
  TRIGGER = File.join '', 'tmp', 'lamptrigger'
  LIGHTS_CONTROLLER_IP = '192.168.232.4'
  STATUS_OID = '1.3.6.1.4.1.19865.2.3.1.15.6.0'
  LIGHTS_DAEMON_SOCKET = File.join '', 'tmp', 'lamper'

  def status
    case snmp_status
    when 1
      :on
    when 0
      :off
    end
  end

  def policy=(new_policy)
    case new_policy
    when :auto
      File.delete TRIGGER
    when :always_on
      File.open TRIGGER, 'w' do |file|
        file.write '{P}~~~ kroci'
      end
    else
      raise ArgumentError.new "Invalid policy specified: %s" % new_policy
    end

    Lights::PolicyManager::InitLab.notify_controller!
  end

  def policy
    if File.exist? TRIGGER
      :always_on
    else
      :auto
    end
  end

  def self.notify_controller!
    begin
      Socket::open(Socket::AF_UNIX, Socket::SOCK_DGRAM, 0) do |socket|
        socket.send '{P}~~~ kroci}', 0, Socket.pack_sockaddr_un(LIGHTS_DAEMON_SOCKET)
      end
    rescue StandardError
      false
    end
  end

  private

  def snmp_status
    SNMP::Manager.open host: LIGHTS_CONTROLLER_IP do |manager|
      begin
        manager.get_value STATUS_OID
      rescue SNMP::RequestTimeout => e
        raise Lights::PolicyManager::Error.new 'A request timeout occurred while querying the lights controller.'
      end
    end
  end
end
