class Door::Actions::Action < ActiveRecord::Base
  include Door::Loggable

  belongs_to :initiator, class_name: User

  after_create :execute!

  def backend_method
    raise NotImplementedError.new("#{self.class}#backend_method not implemented.")
  end

  private

  def execute!
    update execution_succeeded: status_manager.public_send(backend_method)
    true
  end

  def status_manager
    Rails.application.config.door_status_manager.backend
  end
end
