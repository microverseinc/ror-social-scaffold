class AddForeignKeyToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :user_id, :integer, null: false, foreign_key: true
    add_column :friendships, :friend_id, :integer, null: false, foreign_key: true
  end
end
