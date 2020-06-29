class ChangeDefauleValueFalse < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :confirmed, :boolean, :default => false
    #Ex:- :default =>''
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
