class ReformatPhoneNumbers < ActiveRecord::Migration[4.2]
  def change
    execute "UPDATE phone_numbers SET value='359' || value;"
  end
end
