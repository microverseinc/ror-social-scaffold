class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :same_friendship,
        lambda { |user, friend|
          where(
            '(user_id = ? AND friend_id = ?) OR (friend_id = ? AND user_id = ?)',
            user, friend, user, friend
          )
        }

  scope :pending, -> { where('confirmed = false') }
  scope :accepted, -> { where('confirmed = true') }
end
