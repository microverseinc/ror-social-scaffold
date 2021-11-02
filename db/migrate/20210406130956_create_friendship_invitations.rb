class CreateFriendshipInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :friendship_invitations do |t|
      t.references :inviter, null: false, index: true
      t.references :invitee, null: false, index: true
      t.boolean :confirmed

      t.timestamps
    end

    add_foreign_key :friendship_invitations, :users, column: 'inviter_id'
    add_foreign_key :friendship_invitations, :users, column: 'invitee_id'
  end
end
