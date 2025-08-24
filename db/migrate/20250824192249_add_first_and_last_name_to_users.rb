# frozen_string_literal: true

class AddFirstAndLastNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, null: true
    add_column :users, :last_name, :string, null: true
  end
end
