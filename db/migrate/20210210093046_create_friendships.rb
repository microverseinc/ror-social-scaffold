class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :requester_id, null: false, default: ''
      t.integer :addressee_id, null: false, default: ''
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end

    add_index :friendships, :requester_id
    add_index :friendships, :addressee_id
    add_index :friendships, %i[requester_id addressee_id], unique: true
  end
end
