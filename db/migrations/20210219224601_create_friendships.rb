class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|

      t.timestamps
    end
  end
end
