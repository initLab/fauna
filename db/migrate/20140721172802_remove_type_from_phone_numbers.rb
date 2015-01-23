class RemoveTypeFromPhoneNumbers < ActiveRecord::Migration
  def change
    remove_column :phone_numbers, :type, :string
  end
end
