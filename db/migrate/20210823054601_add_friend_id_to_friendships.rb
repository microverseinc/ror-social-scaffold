class AddFriendIdToFriendships < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :friend_id, :integer
  end
end
