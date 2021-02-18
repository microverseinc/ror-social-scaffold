class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :post_id
      t.integer :user_id
    end
    add_foreign_key :likes, :users, column: :user_id
    add_foreign_key :likes, :posts, column: :post_id
  end
end
