class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :inviter
      t.references :invitee
      t.boolean :status, default: false
    end
  end
  
end
