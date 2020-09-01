class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.references :sender, foreign_key: true
      t.references :receiver, foreign_key: true
   
      t.timestamps
    end
  end
end
