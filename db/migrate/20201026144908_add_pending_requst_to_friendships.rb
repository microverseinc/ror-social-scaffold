class AddPendingRequstToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :confirm, :boolean, :default => false
  end
end
