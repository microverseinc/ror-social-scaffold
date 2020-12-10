class AddColumnToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :requester_id, :string
  end
end
