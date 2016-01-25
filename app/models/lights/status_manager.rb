require 'socket'

class Lights::StatusManager
  TRIGGER = File.join '', 'tmp', 'lamptrigger'
  STATUS_OID = '1.3.6.1.4.1.19865.2.3.1.15.6.0'
  LIGHTS_CONTROLLER_IP = '192.168.232.4'
  LIGHTS_DAEMON_SOCKET = '/tmp/lamper'

  def self.notify_controller!
    Socket::open(Socket::AF_UNIX, Socket::SOCK_DGRAM, 0) do |socket|
      socket.send '{P}~~~ kroci}', 0, Socket.pack_sockaddr_un(LIGHTS_DAEMON_SOCKET)
    end
  end

  def self.status
    case snmp_status
    when 1
      :on
    when 0
      :off
    else
      :unknown
    end
  end

  def self.force_on!
    File.open TRIGGER, 'w' do |file|
      file.write '{P}~~~ kroci'
    end and notify_controller!
  end

  def self.auto!
    File.delete(TRIGGER) and notify_controller!
  end

  def self.forced_on?
    File.exist? TRIGGER
  end

  def self.snmp_status
    SNMP::Manager.open host: LIGHTS_CONTROLLER_IP do |manager|
      begin
        manager.get_value STATUS_OID
      rescue SNMP::RequestTimeout => e
        Rails.logger.warn "Error retreiving lights status: #{e}"
        nil
      end
    end
  end

  private_class_method :snmp_status
end
