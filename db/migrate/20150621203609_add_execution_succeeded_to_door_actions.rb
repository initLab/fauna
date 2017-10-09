class AddExecutionSucceededToDoorActions < ActiveRecord::Migration[4.2]
  def change
    add_column :door_actions, :execution_succeeded, :boolean
  end
end
