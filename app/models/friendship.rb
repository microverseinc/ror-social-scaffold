class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user, presence: true 
  validates :friend, presence: true 

  validates :user, uniqueness: { scope: [:friend] }

  before_update :complete_friendship

  def complete_friendship
    if self.confirmed
      Friendship.create(user_id: self.friend.id, friend_id: self.user.id)
    end
  end
end
