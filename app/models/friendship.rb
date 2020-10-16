class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  has_many :confirmed_friends, through: :friendships, source: :friend
  has_many :inverse_friends, through: :friendships, source: :user

  validates :friend, uniqueness: { scope: :user }
end
