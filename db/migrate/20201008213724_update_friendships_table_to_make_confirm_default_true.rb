class UpdateFriendshipsTableToMakeConfirmDefaultTrue < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :confirmed, :boolean, :default => false
  end
end
