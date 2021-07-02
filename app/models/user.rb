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

  def friends
    user_friend_array = Friendship.pluck(:user_id, :friend_id)
    filter_friendships = friendships.select do |friendship|
      user_friend_array.include?([friendship.friend.id, friendship.user.id])
    end
    friends_array = filter_friendships.map(&:friend)
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    user_friend_array = Friendship.pluck(:user_id, :friend_id)
    friendships.map do |friendship|
      friendship.friend unless user_friend_array.include?([friendship.friend.id, friendship.user.id])
    end.compact
  end

  # Users who have requested to be friends
  def friend_requests
    user_friend_array = Friendship.pluck(:user_id, :friend_id)
    inverse_friendships.map do |friendship|
      friendship.user unless user_friend_array.include?([friendship.friend.id, friendship.user.id])
    end.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending?(user)
    pending_friends.include?(user)
  end

  def requested?(user)
    friend_requests.include?(user)
  end
end
