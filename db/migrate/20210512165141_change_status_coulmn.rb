class ChangeStatusCoulmn < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :status, :boolean, :default => false
  end
end
