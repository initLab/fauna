module Door
  class StatusNotification < ActiveRecord::Base
    self.table_name_prefix = 'door_'

    validates :door, presence: true, inclusion: {in: ['Open', 'Closed']}
    validates :latch, presence: true, inclusion: {in: ['Unlocked', 'Locked']}
  end
end
