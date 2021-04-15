class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverse_friendships

  has_many :confirmed_friendships, -> { where status: true }, class_name: :friendships
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where status: false }, class_name: :friendships, foreign_key: :user_id
  has_many :pending_friends, through: :pending_friendships, source: :friend

  # to find all users
  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship unless friendship.confirmed }.compact
  end

  def friend_request
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  # Method to confirm friend requests
  def confirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.confirmed = true
    friendship.save
  end

  # method to check if a given User is our friend
  def friends_with?(user)
    friends.include?(user)
  end
end
