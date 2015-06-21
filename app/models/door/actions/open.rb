class Door::Actions::Open < Door::Actions::Action
  def backend_method
    :open!
  end
end
