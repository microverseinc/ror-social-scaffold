class AddUseridFriendidToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :userid_friendid, :string
  end
end
