class RemoveIdFromFriendship < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE friendships DROP CONSTRAINT friendships_pkey"
    execute "ALTER TABLE friendships ADD PRIMARY KEY (user_id,friend_id);"
    remove_column :friendships, :id
  end
end
