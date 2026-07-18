class AccessMigrateTimestampToTimestampTz < ActiveRecord::Migration[8.1]
  def change
    transaction do
      execute "ALTER TABLE users_roles ALTER start_time TYPE timestamptz USING start_time AT TIME ZONE 'UTC';"
      execute "ALTER TABLE users_roles ALTER end_time TYPE timestamptz USING end_time AT TIME ZONE 'UTC';"
      end
    end
end
