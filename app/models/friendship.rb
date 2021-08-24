class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  def self.accepted_friendship
    where('confirmed =?', true)
  end

  def self.no_friendship
    where('confirmed =?', false)
  end
end
