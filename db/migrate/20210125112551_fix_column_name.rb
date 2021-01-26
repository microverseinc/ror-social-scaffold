class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :friendships, :status, :confirmed
  end
end
