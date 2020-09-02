class AddUniquenessConstraintToFriendRequests < ActiveRecord::Migration[5.2]
  def change
    add_index :friend_requests, [:sender_id, :receiver_id], unique: true
  end
end
