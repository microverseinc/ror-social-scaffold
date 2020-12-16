class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :requesting_user, index: true
      t.references :receiving_user, index: true
      t.boolean :request_status

      t.timestamps
    end
  end
end
