class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.integer :follower_id
      t.integer :leader_id
      t.boolean :status
      
      t.timestamps
    end
  end
end
