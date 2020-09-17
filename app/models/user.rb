class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map do |friendship|
      friendship.friend if friendship.confirmed
    end + inverse_friendships.map do |friendship|
            friendship.user if friendship.confirmed
          end

    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend if !friendship.confirmed && id == friendship.requester_id }.compact
  end

  def friend_requests
    inverse_friendships.map do |friendship|
      friendship.user if !friendship.confirmed && friendship.friend.id == friendship.requester_id
    end .compact
  end

  def confirm_friend(user)
    invers_friendship = inverse_friendships.find { |inverse_friendship| inverse_friendship.user == user }
    regular_friendship = friendships.find { |friendship| friendship.friend == user }

    invers_friendship.confirmed = true
    regular_friendship.confirmed = true

    invers_friendship.save
    regular_friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def requester?(user)
    id == Friendship.find_friendship(self, user).first.requester_id
  end
end
