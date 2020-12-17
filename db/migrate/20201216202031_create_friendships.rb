class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :requesting_user, index: true
      t.references :receiving_user, index: true
      t.boolean :request_status, default: false

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: 'requesting_user_id'
    add_foreign_key :friendships, :users, column: 'receiving_user_id'
  end
end
