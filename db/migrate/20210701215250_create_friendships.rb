class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :inviter, foreign_key: {to_table: :users}
      t.references :invitee, foreign_key: {to_table: :users}
      t.boolean :accepted

      t.timestamps
    end
  end
end
