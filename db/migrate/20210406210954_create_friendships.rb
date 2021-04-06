class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.integer :user
      t.integer :friend

      t.timestamps
    end
  end
end
