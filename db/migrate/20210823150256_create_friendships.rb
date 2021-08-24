class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :confirmed, default: false
      t.integer :friend_id

      t.timestamps
    end
  end
end
