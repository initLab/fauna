class ReformatPhoneNumbers < ActiveRecord::Migration
  def change
    execute "UPDATE phone_numbers SET value='359' || value;"
  end
end
