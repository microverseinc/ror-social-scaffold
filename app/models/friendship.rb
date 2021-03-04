class Friendship < ApplicationRecord
  validates :status, :user_id, :friend_id, presence: true

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
