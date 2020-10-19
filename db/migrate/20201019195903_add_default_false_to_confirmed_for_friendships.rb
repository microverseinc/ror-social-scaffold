class AddDefaultFalseToConfirmedForFriendships < ActiveRecord::Migration[6.0]
  def change
    change_column_default :friendships, :confirmed, false
  end
end
