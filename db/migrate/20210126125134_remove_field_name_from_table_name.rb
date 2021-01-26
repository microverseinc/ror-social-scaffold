class RemoveFieldNameFromTableName < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships, :status, :boolean
  end
end
