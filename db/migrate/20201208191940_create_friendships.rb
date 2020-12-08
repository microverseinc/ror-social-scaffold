class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :sender, index: true, class_name: :User
      t.references :receiver, index: true, class_name: :User
      t.boolean :status

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :sender_id
    add_foreign_key :friendships, :users, column: :receiver_id
  end
end
