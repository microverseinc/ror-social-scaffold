class ChangeFriendshipInvitationsToFriendships < ActiveRecord::Migration[6.0]
  def change
    rename_table :friendship_invitations, :friendships
  end
end
