class Friendship < ApplicationRecord
  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates_uniqueness_of :friend_id, scope: :user_id

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
