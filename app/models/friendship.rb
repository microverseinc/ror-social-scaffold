class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :pending_friend_requests, -> { where confirmed == false }
end
