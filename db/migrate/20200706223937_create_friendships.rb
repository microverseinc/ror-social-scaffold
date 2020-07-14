class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :requester_id, index: true, foreign_key: true
      t.integer :receiver_id, index: true, foreign_key: true
      t.boolean :confirmed, default: false
      t.timestamps
    end

    add_foreign_key :friendships, :users, column: :requester_id
    add_foreign_key :friendships, :users, column: :receiver_id
  end
end
