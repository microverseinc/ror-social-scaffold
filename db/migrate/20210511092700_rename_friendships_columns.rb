class RenameFriendshipsColumns < ActiveRecord::Migration[6.0]
  def change
    change_table(:friendships) do |t|
      t.rename :inviter_id, :user_id
      t.rename :invitee_id, :friend_id
    end
  end
end
