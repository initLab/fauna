class Lights::Policy
  include Authority::Abilities
  self.authorizer_name = 'LightsPolicyAuthorizer'

  def initialize(policy)
    @policy = policy[:policy]
  end

  def update
    if @policy == 'force_on'
      Lights::StatusManager.force_on!
    elsif @policy == 'auto'
      Lights::StatusManager.auto!
    else
      false
    end
  end
end
