class AddTimesToUsersRoles < ActiveRecord::Migration[8.1]
  def up
    add_column :users_roles, :start_time, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :users_roles, :end_time, :datetime, null: true

    execute('ALTER TABLE users_roles ADD PRIMARY KEY (user_id, role_id, start_time)')
  end

  def down
    remove_column :users_roles, :start_time
    remove_column :users_roles, :end_time

    execute('ALTER TABLE users_roles DROP CONSTRAINT users_roles_pkey')
  end
end
