class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships # , :class_name => "Friendship"

  # confirmed friend
  has_many :confirmed_friendships, -> { where acceptance: true },
           class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  # inverse pair
  has_many :inverted_friendships, -> { where acceptance: false },
           class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships

  # pending friends
  has_many :pending_friendships, -> { where acceptance: false },
           class_name: 'Friendship', foreign_key: 'user_id'
  # has_many :pending_friends,
  #   through: :pending_friendships, source: :friend
end
