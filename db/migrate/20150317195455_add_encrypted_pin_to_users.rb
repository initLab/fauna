class AddEncryptedPinToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :encrypted_pin, :string
  end
end
