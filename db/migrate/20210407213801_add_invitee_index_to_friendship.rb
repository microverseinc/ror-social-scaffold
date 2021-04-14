class AddInviteeIndexToFriendship < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :invitee_id, :integer
    add_index :friendships, :invitee_id
  end
end
