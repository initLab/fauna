class AuditLog::Entry < ApplicationRecord
  belongs_to :user, optional: true
end
