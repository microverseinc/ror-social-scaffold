class AddInvitorAndInviteeIdsToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :friendships, :users, column: :invitor_id
    add_foreign_key :friendships, :users, column: :invitee_id
  end
end
