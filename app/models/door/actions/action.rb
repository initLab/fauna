class Door::Actions::Action < ActiveRecord::Base
  include Door::Loggable
  include Authority::Abilities

  belongs_to :initiator, class_name: User

  after_create :execute!

  def backend_method
    raise NotImplementedError.new("#{self.class}#backend_method not implemented.")
  end

  def self.from_name(name)
    {
      open: Door::Actions::Open,
      lock: Door::Actions::Lock,
      unlock: Door::Actions::Unlock
    }[name.to_sym].try(:new)
  end

  def to_s
    self.class.model_name.human
  end

  def public_message
    initiator_name = 'Somebody'

    if initiator.present?
      if initiator.privacy
        initiator_name = 'Somebody who does not wish to be named'
      else
        initiator_name = initiator.username
      end
    end

    "#{initiator_name} #{self.class.model_name.human(locale: :en).downcase}ed the door"
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
