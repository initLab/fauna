module Lights
  class CurrentStatus
    def initialize
      @policy_manager = Rails.application.config.lights_policy_manager.new
    end

    def policy
      @policy_manager.policy
    end

    def status
      @policy_manager.status
    end
  end
end
