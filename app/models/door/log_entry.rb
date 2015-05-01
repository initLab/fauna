module Door
  class LogEntry < ActiveRecord::Base
    self.table_name_prefix = 'door_'

    validates :door, presence: true, inclusion: {in: ['open', 'closed']}
    validates :latch, presence: true, inclusion: {in: ['unlocked', 'locked']}
  end
end
