class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :leader_id
      t.boolean :status

      t.timestamps
    end
  end
end
