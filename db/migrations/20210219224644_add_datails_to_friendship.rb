class AddDatailsToFriendship < ActiveRecord::Migration[5.2]
  def change
    add_reference :friendships, :sent_friendship
    add_reference :friendships, :received_friendship
    add_column :friendships, :status, :boolean,  default: false
  end
end
