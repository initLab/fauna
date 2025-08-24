# frozen_string_literal: true

class DeleteNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :name, :string
  end
end
