class Friendship < ApplicationRecord
  after_save :full_friend
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :same_friendship,
        lambda { |user, friend|
          where(
            'user_id = ? AND friend_id = ?',
            user, friend
          )
        }

  scope :pending, -> { where('confirmed = false') }
  scope :accepted, -> { where('confirmed = true') }

  def inverse
    Friendship.where('user_id = ? AND friend_id = ?', friend_id, user_id).take
  end

  def full_friend
    Friendship.create(user_id: friend_id, friend_id: user_id) unless Friendship.same_friendship(friend_id, user_id).any?
  end
end
