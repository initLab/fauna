class IrcNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    if Rails.env.production?
      Services::IrcSpammer.send_message message
    else
      Rails.logger.info "Sent IRC notification: #{message}"
    end
  end
end
