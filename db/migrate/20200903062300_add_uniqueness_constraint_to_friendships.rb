class AddUniquenessConstraintToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, [:friend_id, :inverse_friend_id], unique: true
  end
end
