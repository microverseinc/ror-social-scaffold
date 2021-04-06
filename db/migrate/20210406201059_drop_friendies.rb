class DropFriendies < ActiveRecord::Migration[6.0]
  def change
    drop_table :friendies
  end
end
