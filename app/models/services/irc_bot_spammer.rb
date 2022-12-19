require "socket"

class Services::IrcBotSpammer
  IRC_BOT_SOCKET = File.join "", "tmp", "ircbot.sock"

  def self.send_message(message)
    new.send message
  end

  def send(message)
    Socket.unix(IRC_BOT_SOCKET) do |socket|
      socket.write "notice #initlab #{message}\n"
    end
  end
end
