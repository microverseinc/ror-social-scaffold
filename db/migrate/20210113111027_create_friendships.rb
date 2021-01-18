class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, index: true
      t.integer :friend_id, index: true, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
