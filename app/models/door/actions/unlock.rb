class Door::Actions::Unlock < Door::Actions::Action
  def backend_method
    :unlock!
  end
end
