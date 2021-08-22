class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :request_sent_to, null: false, foreign_key: {to_table: :users}
      t.references :request_sent_by, null: false, foreign_key: {to_table: :users}
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
