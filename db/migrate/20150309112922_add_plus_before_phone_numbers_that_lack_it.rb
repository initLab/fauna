class AddPlusBeforePhoneNumbersThatLackIt < ActiveRecord::Migration[4.2]
  def change
    execute "UPDATE phone_numbers SET phone_number='+' || phone_number WHERE phone_number NOT LIKE '+%';"
  end
end
