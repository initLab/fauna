class UserRole < ApplicationRecord
  self.table_name = :users_roles

  belongs_to :role
  belongs_to :user

  scope :active_at, ->(time) { where('(start_time < ?) and (end_time is null or end_time > ?)', time, time) }
  default_scope { where('(start_time < ?) and (end_time is null or end_time > ?)', Time.current, Time.current) }
end
