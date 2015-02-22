class AddGpgFingerprintToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gpg_fingerprint, :string
  end
end
