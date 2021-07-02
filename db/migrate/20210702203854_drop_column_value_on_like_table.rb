class DropColumnValueOnLikeTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :value, :boolean
  end
end
