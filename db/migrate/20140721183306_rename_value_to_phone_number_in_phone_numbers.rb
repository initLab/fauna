class RenameValueToPhoneNumberInPhoneNumbers < ActiveRecord::Migration[4.2]
  def change
    rename_column :phone_numbers, :value, :phone_number
  end
end
