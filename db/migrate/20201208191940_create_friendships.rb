class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :sender, foreign_key: true
      t.references :receiver, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
