class IrcBotNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    unless Rails.env.production?
      Rails.logger.info "Sent IRC notification: #{message}"
    else
      Services::IrcBotSpammer.send_message message
    end
  end
end
