module Lights
  class Policy
    include Authority::Abilities
    self.authorizer_name = 'LightsPolicyAuthorizer'

    def initialize(policy)
      @policy = policy[:policy]
      @policy_manager = Rails.application.config.lights_policy_manager.new
    end

    def update
      if @policy == 'always_on'
        @policy_manager.policy = :always_on
      elsif @policy == 'auto'
        @policy_manager.policy = :auto
      else
        false
      end
    end
  end
end
