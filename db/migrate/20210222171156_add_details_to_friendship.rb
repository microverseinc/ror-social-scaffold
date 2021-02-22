class AddDetailsToFriendship < ActiveRecord::Migration[5.2]
  def change
    add_reference :friendships, :user
    add_reference :friendships, :friend
    add_column :friendships, :status, :boolean, default: false
  end
end
