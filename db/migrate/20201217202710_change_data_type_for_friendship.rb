class ChangeDataTypeForFriendship < ActiveRecord::Migration[5.2]
  def self.up
    change_table :friendships do |t|
      t.change :confirmed, :boolean
    end
  end

  def self.down
    change_table :friendships do |t|
      t.change :status, :string
    end
  end
end
