module Door
  class StatusNotification < ApplicationRecord
    self.table_name_prefix = 'door_'

    include Loggable

    validates :door, presence: true, inclusion: {in: ['Open', 'Closed']}
    validates :latch, presence: true, inclusion: {in: ['Unlocked', 'Locked']}

    def public_message
      message = 'The door is now '

      previous_status = StatusNotification.find_by(id: id - 1)

      if previous_status.present?
        changes = []
        changes << latch if previous_status.latch != latch
        changes << door if previous_status.door != door
        message += changes.join(' and ')
      else
        message += "#{latch} and #{door}"
      end

      message
    end
  end
end
