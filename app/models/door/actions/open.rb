class Door::Actions::Open < Door::Actions::Action
  private

  def execute!
    update execution_succeeded: status_manager.open!
    true
  end
end
