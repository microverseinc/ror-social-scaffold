class AddUserReferencesToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_reference :friendships, :user, foreign_key: true
  end
end
