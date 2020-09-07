class DropFriendRequestsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :friend_requests
  end
end
