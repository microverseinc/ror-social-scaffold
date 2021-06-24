class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :friendship_id
      t.references :user, null: false, foreign_key: true
      t.references :friend, null: false
      t.boolean :confirmed

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
