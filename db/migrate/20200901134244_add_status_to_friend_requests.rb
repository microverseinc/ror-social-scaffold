class AddStatusToFriendRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :friend_requests, :status, :string, default: 'pending'
  end
end
