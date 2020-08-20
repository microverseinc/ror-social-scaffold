class IndexFriendshipsOnFriendId < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, :friend_id
  end
end
