class AddConfirmedToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :confirmed, :boolean
  end
end
