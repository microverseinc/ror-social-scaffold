class CreateFriendrequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendrequests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend, index: true
      t.boolean :status

      t.timestamps null:false
    end
    add_foreign_key :friendrequests, :users, column: :friend_id
  end
end
