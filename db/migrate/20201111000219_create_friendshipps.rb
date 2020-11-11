class CreateFriendshipps < ActiveRecord::Migration[5.2]
  def change
    create_table :friendshipps do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend, index: true
      t.boolean :confirmed

      t.timestamps null: false
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
