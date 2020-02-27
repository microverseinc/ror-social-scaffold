class AddIndexToFriendShips < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, :friend_id
    add_index :friendships, :friendable_id
  end
end
