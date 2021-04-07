class AddConfirmedDefaultValueToFriendshipInvitation < ActiveRecord::Migration[6.0]
  def change
    change_column_default :friendship_invitations, :confirmed, false
  end
end
