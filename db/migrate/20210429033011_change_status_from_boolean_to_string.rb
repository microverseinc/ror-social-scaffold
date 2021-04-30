class ChangeStatusFromBooleanToString < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :status, :string
  end
end
