class CreateAuditLogEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :audit_log_entries do |t|
      t.string :type
      t.references :user, null: true, foreign_key: true, default: nil
      t.json :payload

      t.timestamps
    end
    add_index :audit_log_entries, :type
  end
end
