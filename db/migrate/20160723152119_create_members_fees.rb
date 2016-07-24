class CreateMembersFees < ActiveRecord::Migration
  def change
    create_table :members_fees do |t|
      t.references :user, index: true, foreign_key: true
      t.date :month

      t.timestamps null: false
    end
  end
end
