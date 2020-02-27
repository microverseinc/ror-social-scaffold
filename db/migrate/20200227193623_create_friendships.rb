class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :friendable_id
      t.integer :friend_id
      t.integer :status

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friendable_id
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
