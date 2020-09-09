class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.boolean :status
      t.references :user, foreign_key: true, index: true
      t.references :friend, index: true

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end