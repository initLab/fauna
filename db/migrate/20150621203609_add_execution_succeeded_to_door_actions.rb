class AddExecutionSucceededToDoorActions < ActiveRecord::Migration
  def change
    add_column :door_actions, :execution_succeeded, :boolean
  end
end
