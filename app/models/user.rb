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

  has_many :pending_friendships, -> { where status: nil }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_requests, through: :pending_friendships, source: :friend

  def friends
    friends_array = friendships.map { |f| f.friend if f.status }
    friends_array.compact
  end

  # Users who have yet to confirm friend request
  def sent_requests
    friendships.map { |f| f.friend unless f.status }.compact
  end

  def recieved_requests
    inverse_friendships.map { |f| f.user unless f.status }.compact
  end

  def request_friend(user)
    return false if relation_exist?(user)

    friendship = friendships.build
    friendship.friend_id = user.id
    friendship.user_id = current_user.id
    friendship.status = false
    friendship.save
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship2 = friendships.build
    friendship2.user_id = id
    friendship2.friend_id = user.id
    friendship2.status = true
    friendship.status = true
    friendship.save
    friendship2.save
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def friendship(friend)
    friendships.find { |f| f.friend_id == friend.id }
  end

  def relation_exist?(user)
    friends.include?(user) || pending_requests.include?(user) || user == self
  end
end
