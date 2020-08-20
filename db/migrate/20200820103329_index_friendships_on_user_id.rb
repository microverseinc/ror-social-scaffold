class IndexFriendshipsOnUserId < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, :user_id
  end
end
