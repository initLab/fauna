class RenameValueToPhoneNumberInPhoneNumbers < ActiveRecord::Migration
  def change
    rename_column :phone_numbers, :value, :phone_number
  end
end
