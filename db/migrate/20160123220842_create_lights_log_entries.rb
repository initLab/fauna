class CreateLightsLogEntries < ActiveRecord::Migration[4.2]
  def change
    create_table :lights_log_entries do |t|
      t.references :loggable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
