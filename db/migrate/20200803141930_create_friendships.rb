class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :status

      t.timestamps
      t.index :user_id
      t.index :friend_id
      
    end
  end
end
