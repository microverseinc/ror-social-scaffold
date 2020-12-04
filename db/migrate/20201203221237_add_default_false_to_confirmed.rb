class AddDefaultFalseToConfirmed < ActiveRecord::Migration[5.2]
  def change
    change_column_default :friendships, :confirmed, false
  end
end
