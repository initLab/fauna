class IrcNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    Services::IrcSpammer.send_message message
  end
end
