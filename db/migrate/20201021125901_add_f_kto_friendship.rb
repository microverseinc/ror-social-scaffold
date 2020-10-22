class AddFKtoFriendship < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
