require 'jsonclient'

class Door::StatusManager::Pesho
  def initialize
    @base_uri = Rails.application.config.door_status_manager.url
    @client = JSONClient.new
    @client.connect_timeout = Rails.application.config.door_status_manager.timeout
    @client.send_timeout = Rails.application.config.door_status_manager.timeout
    @client.receive_timeout = Rails.application.config.door_status_manager.timeout
  end

  def status
    response = @client.get("#{@base_uri}/status", query: {'key' => key})

    if response.ok?
      response.body
    else
      raise Door::StatusManager::UnexpectedResponseCodeError.new response.status
    end
  end

  private

  def key
    Rails.application.secrets['door_status_manager_key']
  end
end
