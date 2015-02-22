class AddGithubAndJabberFieldsFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github, :string
    add_column :users, :jabber, :string
  end
end
