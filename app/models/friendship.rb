class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  def self.accepted_friendship
    where('confirmed =?', true)
  end

  def self.no_friendship
    where('confirmed =?', false).where('friend_id <?', 1)
  end

  def self.confirmed_friendship
    where('confirmed =?', true).where('friend_id >=?', 1)
  end

  def self.pending_friendship
    where('confirmed =?', false).where('friend_id >=?', 1)
  end
end
