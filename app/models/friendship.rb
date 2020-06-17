class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_update :reverse_friend

  def reverse_friend
    Friendship.create(
      user_id: friend.id,
      friend_id: user.id,
      acceptance: true
    )
  end
end
