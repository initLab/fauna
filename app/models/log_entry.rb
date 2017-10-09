class LogEntry < ApplicationRecord
  belongs_to :loggable, polymorphic: true
end
