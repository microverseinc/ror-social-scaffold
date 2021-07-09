class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :inviter, null: false, foreign_key: { to_table: :users }, index: true
      t.references :invitee, null: false, foreign_key: { to_table: :users }, index: true
      
      t.timestamps
    end
  end
end
