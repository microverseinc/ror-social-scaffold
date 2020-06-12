class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :confirmer_id, index: true
      t.integer :requester_id, index: true
      t.boolean :status

      t.timestamps
    end
  end
end
