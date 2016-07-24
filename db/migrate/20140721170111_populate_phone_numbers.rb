class PopulatePhoneNumbers < ActiveRecord::Migration[4.2]
  def up
    execute "INSERT INTO phone_numbers SELECT * FROM objects WHERE type='phone';"
  end

  def down
    execute 'INSERT INTO objects SELECT * FROM phone_numbers;'
  end
end
