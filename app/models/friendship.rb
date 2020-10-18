class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  has_many :confirmed_friends, through: :friendships, source: :friend
  has_many :inverse_friends, through: :friendships, source: :user

  validates :friend, uniqueness: { scope: :user }
  validates_presence_of :user_id, :friend_id
end
