require "shellwords"

class AccessControl::DoorControllers::ShellScript
  def initialize(script:)
    @script = script
  end

  def call(action)
    system([@script, action].shelljoin) || raise("Error executing command: #{$?}")
  end
end
