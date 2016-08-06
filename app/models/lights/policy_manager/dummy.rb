class Lights::PolicyManager::Dummy
  def initialize
    @policy = :auto
  end

  def status
    :on
  end

  def policy=(new_policy)
    unless [:auto, :always_on].include? new_policy
      raise ArgumentError.new "Invalid policy specified: %s" % new_policy
    end

    @policy = new_policy
  end

  def policy
    @policy
  end

  def self.notify_controller!
    true
  end
end
