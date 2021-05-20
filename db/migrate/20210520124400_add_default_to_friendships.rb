class AddDefaultToFriendships < ActiveRecord::Migration[5.2]
  def change
    change_column_default :friendships, :status, :requested
  end
end
