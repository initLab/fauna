class RemoveForeignKeys < ActiveRecord::Migration[4.2]
  def down
    add_foreign_key "objects", "users", name: "objects_userid_fk", column: "userid", dependent: :delete
  end

  def up
    remove_foreign_key "objects", name: "objects_userid_fk"
  end
end
