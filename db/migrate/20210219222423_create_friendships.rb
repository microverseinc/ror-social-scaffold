class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :received_friendship, foreign_key: true
      t.references :sent_friendship, foreign_key: true
      t.boolean :confirmed

      t.timestamps
    end
  end
end
