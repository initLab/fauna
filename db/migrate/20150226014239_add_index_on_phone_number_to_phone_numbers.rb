class AddIndexOnPhoneNumberToPhoneNumbers < ActiveRecord::Migration[4.2]
  def change
    add_index :phone_numbers, :phone_number
  end
end
