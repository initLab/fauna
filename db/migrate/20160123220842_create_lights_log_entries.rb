class CreateLightsLogEntries < ActiveRecord::Migration
  def change
    create_table :lights_log_entries do |t|
      t.references :loggable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
