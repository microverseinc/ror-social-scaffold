class AddForeignKeyToFriendship < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :friendships, :users, column: :requester_id
    add_index :friendships, :requester_id
  end
end
