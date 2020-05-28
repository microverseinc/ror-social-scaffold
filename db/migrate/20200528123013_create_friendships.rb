class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.boolean :status

      t.timestamps
    end
  end
end
