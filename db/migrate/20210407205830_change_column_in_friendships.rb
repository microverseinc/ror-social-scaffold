class ChangeColumnInFriendships < ActiveRecord::Migration[6.0]
  def change
    change_column_null :friendships, :status, false
    change_column_default :friendships, :status, from: nil, to: false
  end
end
