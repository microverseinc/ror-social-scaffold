class AddUserIdToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :user_id, :integer
  end
end
