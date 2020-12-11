class AddColumnToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :requestor_id, :integer
  end
end
