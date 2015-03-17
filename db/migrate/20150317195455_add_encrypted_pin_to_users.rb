class AddEncryptedPinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_pin, :string
  end
end
