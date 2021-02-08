class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, foreign_key: :friend_id, class_name: 'User'

  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates :userid_friendid, presence: true, uniqueness: true
end
