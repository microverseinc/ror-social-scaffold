class ChangeStatusToBoolean < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :status, :boolean
  end
end
