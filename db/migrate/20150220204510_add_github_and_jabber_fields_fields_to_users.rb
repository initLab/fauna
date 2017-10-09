class AddGithubAndJabberFieldsFieldsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :github, :string
    add_column :users, :jabber, :string
  end
end
