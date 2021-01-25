class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :friendships, :confirmed, :status
  end
end
