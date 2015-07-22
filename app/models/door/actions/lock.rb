class Door::Actions::Lock < Door::Actions::Action
  self.authorizer_name = 'DoorHandleAuthorizer'

  def backend_method
    :lock!
  end
end
