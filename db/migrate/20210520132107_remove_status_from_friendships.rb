class RemoveStatusFromFriendships < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships, :status, :string
  end
end
