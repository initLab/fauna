class RemoveAllPhones < ActiveRecord::Migration
  def change
    execute "DELETE FROM objects WHERE type='phone';"
  end
end
