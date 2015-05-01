module Door
  class LogEntry < ActiveRecord::Base
    self.table_name_prefix = 'door_'
  end
end
