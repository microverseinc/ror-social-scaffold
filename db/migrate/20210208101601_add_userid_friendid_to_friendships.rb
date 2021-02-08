class AddUseridFriendidToFriendships < ActiveRecord::Migration[6.1]
  def change
    add_column :friendships, :userid_friendid, :string
  end
end
