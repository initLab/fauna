class AddPictureToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :picture, :string
  end
end
