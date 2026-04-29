# frozen_string_literal: true

module AuditLog
  class Entry < ApplicationRecord
    belongs_to :user, optional: true
  end
end
