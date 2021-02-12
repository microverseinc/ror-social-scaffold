class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :requestor_id
      t.integer :requested_id

      t.timestamps
    end

    add_index :friendships, :requestor_id
    add_index :friendships, :requested_id

    add_foreign_key :friendships, :users, column: :requestor_id
    add_foreign_key :friendships, :users, column: :requested_id
  end
end
