class RemoveColumnsFromFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :friend_id, :integer
    remove_column :friendships, :sender_id
    remove_column :friendships, :reciever_id
  end
end
