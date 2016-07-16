class IrcNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    if ENV['RAILS_ENV'] != 'production'
      Rails.logger.info "Sent IRC notification: #{message}"
    else
      Services::IrcSpammer.send_message message
    end
  end
end
