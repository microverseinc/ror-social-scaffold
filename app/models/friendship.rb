class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :find_friendship, ->(friend) { where(friend_id: friend) }

  scope :find_inverse_friendship, ->(friend) { where(user_id: friend) }
end
