# frozen_string_literal: true
class UserRole < ApplicationRecord
  self.table_name = :users_roles

  belongs_to :role
  belongs_to :user

  scope :expired, -> { unscope(where: %i[start_time end_time]).where('(end_time is not null and end_time < ?)', Time.current) }
  scope :future, -> { unscope(where: %i[start_time end_time]).where('(start_time is not null and start_time > ? and (end_time is null or end_time > ?))', Time.current, Time.current) }

  scope :active_at, ->(time) { unscope(where: %i[start_time end_time]).where('(start_time < ?) and (end_time is null or end_time > ?)', time, time) }

  default_scope { where(start_time: ...Time.current).and(where(end_time: nil).or(where(end_time: Time.current...))) }

  def deactivate
    update(end_time: Time.current)
  end
end
