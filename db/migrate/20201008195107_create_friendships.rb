class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :sent_by, null: false, foreign_key: { to_table: :users }
      t.references :sent_to, null: false, foreign_key: { to_table: :users }
      t.boolean :confirmed

      t.timestamps
    end
  end
end
