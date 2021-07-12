class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :user, foreign_key: true
      t.integer :friend_id
      t.boolean :confirmed,
      default: :false  

      t.timestamps
    end
  end
end
