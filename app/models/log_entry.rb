# frozen_string_literal: true

class LogEntry < ApplicationRecord
  belongs_to :loggable, polymorphic: true
end
