class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_destroy :destroy_friendship

  scope :requested_friendships, -> { where(confirmed: false) }

  def destroy_friendship
    friend.friends.delete(user)
  end
end
