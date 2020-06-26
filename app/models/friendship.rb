class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  after_update :friendship_symmetry,
               unless: [proc { |c| c.friend.friendships.find_by(friend_id: c.user.id) }]
  validate :cannot_friend_self

  def cannot_friend_self
    errors.add(:friend_id, 'cannot friend self') if user_id == friend_id
  end

  def friendship_symmetry
    friend.friendships.create(friend_id: user.id, status: true)
  end
end
