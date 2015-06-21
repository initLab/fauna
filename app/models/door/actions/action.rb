class Door::Actions::Action < ActiveRecord::Base
  include Door::Loggable

  belongs_to :initiator, class_name: User

  after_create :execute!

  private

  def execute!
    raise NotImplementedError.new("#{self.class}#execute! not implemented.")
  end

  def status_manager
    Rails.application.config.door_status_manager_backend
  end
end
