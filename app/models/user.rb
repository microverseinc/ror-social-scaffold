class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friendly_requests, through: :friendships

  has_many :friends, -> {merge(Friendship.accepted_friendship)}, through: :friendly_requests
  has_many :request_pending, -> {merge(Friendship.no_friendship)}, through: :friendly_requests
end
