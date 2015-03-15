class DoorStatus
  @retreived = false

  def door
    retreive! unless @retreived
    @door_state
  end

  def latch
    retreive! unless @retreived
    @latch_state
  end

  private

  def retreive!
    status = {'door' => 'unknown', 'latch' => 'unknown'}

    begin
      response = Rails.application.config.door_status_manager_backend.new.status

      if response.response.code == '200'
        status = response.parsed_response
        @retreived = true
      end
    rescue
      Rails.logger.error "Error retreiving door status."
    end

    @door_state = status['door'].to_sym
    @latch_state = status['latch'].to_sym
  end
end
