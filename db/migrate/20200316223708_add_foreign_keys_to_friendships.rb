class AddForeignKeysToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, :user_id
    add_foreign_key :friendships, :users

    add_index :friendships, :friend_id
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
