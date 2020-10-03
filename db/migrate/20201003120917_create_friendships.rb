class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :invitor, index: true
      t.references :invitee, index: true
      t.boolean :status

      t.timestamps
    end
  end
end
