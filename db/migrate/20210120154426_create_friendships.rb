class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|

      t.belongs_to :user
      t.belongs_to :friend
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
