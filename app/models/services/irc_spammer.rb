require 'socket'
require 'openssl'

class Services::IrcSpammer
  def initialize
    # To be extracted if ever needed
    @server, @port, @channel, @name = 'irc.ludost.net', 6697, '#initLab', 'cassie'
  end

  def self.send_message(message)
    spammer = new
    spammer.spam(message)
  end

  def spam(message)
    irc.puts "NICK #{@name}"
    irc.puts "USER #{@name} 8 * :#{@name}"

    loop do
      case irc.gets
      when / 00[1-4] #{Regexp.escape(@name)} /
        break
      when /^PING\s*:\s*(.*)$/
        irc.puts "PONG #{$1}"
      end
    end

    irc.puts "NOTICE #{@channel} :#{message}"
    irc.puts "QUIT"

    irc.gets until irc.eof?
    irc.close
  rescue SocketError => boom
    if boom.to_s =~ /getaddrinfo: Name or service not known/
      raise 'Invalid host'
    elsif boom.to_s =~ /getaddrinfo: Servname not supported for ai_socktype/
      raise 'Invalid port'
    else
      raise
    end
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
    raise 'Invalid host'
  rescue OpenSSL::SSL::SSLError
    raise 'Host does not support SSL'
  end

  private

  def irc
    @irc ||= begin
               socket = TCPSocket.open(@server, @port)
               ssl_context = OpenSSL::SSL::SSLContext.new()
               ssl_context.ssl_version = :TLSv1_2_client
               ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
               ssl_socket.sync_close = true
               ssl_socket.connect
               ssl_socket
             end
  end
end
