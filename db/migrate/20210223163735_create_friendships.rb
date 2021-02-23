class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :requester_id, null: false, default: ''
      t.integer :receiver_id, null: false, default: ''
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end

    add_index :friendships, :requester_id
    add_index :friendships, :receiver_id
    add_index :friendships, %i[requester_id receiver_id], unique: true
  end
end
