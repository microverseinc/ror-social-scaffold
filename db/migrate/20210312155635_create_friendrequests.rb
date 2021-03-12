class CreateFriendrequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendrequests do |t|
      t.references :user, foreign_key: true
      t.references :friend, foreign_key: true
      t.boolean :status

      t.timestamps null:false
    end
    add_foreign_key :friendrequests, :user, column: :friend_id
  end
end
