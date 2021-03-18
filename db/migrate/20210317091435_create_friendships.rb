class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.string :user_id
      t.string :friendship_id
      t.string :status

      t.timestamps
    end
    add_index :friendships, :user_id
    add_index :friendships, :friendship_id
  end
end
