class RemoveGpgFingerprintFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :gpg_fingerprint, :string
  end
end
