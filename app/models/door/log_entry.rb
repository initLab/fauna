module Door
  class LogEntry < ActiveRecord::Base
    self.table_name_prefix = 'door_'

    belongs_to :loggable, polymorphic: true
  end
end
