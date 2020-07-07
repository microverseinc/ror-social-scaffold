class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create :reciprocate_friendship
  after_destroy :destroy_friendship

  def reciprocate_friendship
    friend.friends << user unless friend.friends.include?(user)
  end

  def destroy_friendship
    friend.friends.delete(user)
  end
end
