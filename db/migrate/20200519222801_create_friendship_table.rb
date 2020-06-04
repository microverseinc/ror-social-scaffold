class CreateFriendshipTable < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships, id: false do |t|
      t.bigint :id
      t.belongs_to :user
      t.belongs_to :friend
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
