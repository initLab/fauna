class RemoveTypeFromPhoneNumbers < ActiveRecord::Migration[4.2]
  def change
    remove_column :phone_numbers, :type, :string
  end
end
