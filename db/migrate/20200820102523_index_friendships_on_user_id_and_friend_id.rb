class IndexFriendshipsOnUserIdAndFriendId < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, [:user_id, :friend_id], unique: true
  end
end
