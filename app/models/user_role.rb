class UserRole < ApplicationRecord
  self.table_name = :users_roles

  belongs_to :role
  belongs_to :user

  scope :expired, -> { where('(end_time is not null and end_time < ?)', Time.current) }
  scope :future, -> { where('(start_time is not null and start_time > ?)', Time.current) }

  scope :active_at, ->(time) { where('(start_time < ?) and (end_time is null or end_time > ?)', time, time) }
  default_scope { where('(start_time < ?) and (end_time is null or end_time > ?)', Time.current, Time.current) }
end
