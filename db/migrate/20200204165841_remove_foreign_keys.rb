class RemoveForeignKeys < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :comments, :users
    remove_foreign_key :likes, :posts
    remove_foreign_key :likes, :users

    add_index :comments, :user_id
    add_index :likes, :post_id
    add_index :likes, :user_id
  end
end
