class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :requester, index: true, foreign_key: true
      t.references :receiver, index: true, foreign_key: true
      t.boolean :confirmed, default: false

      t.timestamps
    end

    add_foreign_key :friendships, :users, column: :requester
    add_foreign_key :friendships, :users, column: :receiver
  end
end
