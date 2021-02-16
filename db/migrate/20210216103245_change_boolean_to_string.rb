class ChangeBooleanToString < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :confirmed, :string
end
end
