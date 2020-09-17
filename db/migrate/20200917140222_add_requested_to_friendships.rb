class AddRequestedToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :requester_id, :integer, null: false
  end
end
