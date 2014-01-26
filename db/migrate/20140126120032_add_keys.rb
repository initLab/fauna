class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "objects", "users", name: "objects_userid_fk", column: "userid", dependent: :delete
  end
end
