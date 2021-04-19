class ChangeColumnTypeInFriendships < ActiveRecord::Migration[6.1]
  def change
    remove_column :friendships, :status
    add_column :friendships, :status, :integer, default: 0
  end
end
