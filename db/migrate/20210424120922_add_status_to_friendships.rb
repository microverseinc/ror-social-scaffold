class AddStatusToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :status, :string
  end
end
