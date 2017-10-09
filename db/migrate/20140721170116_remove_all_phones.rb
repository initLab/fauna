class RemoveAllPhones < ActiveRecord::Migration[4.2]
  def change
    execute "DELETE FROM objects WHERE type='phone';"
  end
end
