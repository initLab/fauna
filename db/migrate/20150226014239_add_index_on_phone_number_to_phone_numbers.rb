class AddIndexOnPhoneNumberToPhoneNumbers < ActiveRecord::Migration
  def change
    add_index :phone_numbers, :phone_number
  end
end
