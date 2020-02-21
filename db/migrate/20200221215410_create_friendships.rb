class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :sender, index: true
      t.references :reciever, index: true
      t.boolean :status

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :sender_id
    add_foreign_key :friendships, :users, column: :reciever_id
  end
end
