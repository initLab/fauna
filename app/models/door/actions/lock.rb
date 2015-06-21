class Door::Actions::Lock < Door::Actions::Action
  def backend_method
    :lock!
  end
end
