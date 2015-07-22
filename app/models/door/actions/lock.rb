class Door::Actions::Lock < Door::Actions::Action
  self.authorizer_name = 'DoorLatchAuthorizer'

  def backend_method
    :lock!
  end
end
