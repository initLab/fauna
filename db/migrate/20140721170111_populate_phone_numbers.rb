class PopulatePhoneNumbers < ActiveRecord::Migration
  def up
    execute "INSERT INTO phone_numbers SELECT * FROM objects WHERE type='phone';"
  end

  def down
    execute 'INSERT INTO objects SELECT * FROM phone_numbers;'
  end
end
