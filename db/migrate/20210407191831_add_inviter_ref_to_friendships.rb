class AddInviterRefToFriendships < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :inviter_id, :integer
    add_index :friendships, :inviter_id
  end
end
