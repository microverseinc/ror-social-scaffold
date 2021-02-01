class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: 'requesting_user_id'

  has_many :friendship_requests, foreign_key: 'receiving_user_id', class_name: 'Friendship'
  has_many :pending_friends, through: :friendship_requests, source: :receiving_user

  has_many :inverse_friendship_requests, foreign_key: 'requesting_user_id', class_name: 'Friendship'
  has_many :friend_requests, through: :inverse_friendship_requests, source: :requesting_user

  def friends
    friend_request_array = friendships.map { |friendship| friendship.receiving_user if friendship.request_status }
    received_friend_request_array = friendship_requests.map do |friendship|
      friendship.requesting_user if friendship.request_status
    end
    (friend_request_array + received_friend_request_array).compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.receiving_user unless friendship.request_status }.compact
  end

  def friend_requests
    friendship_requests.map { |friendship| friendship.requesting_user unless friendship.request_status }.compact
  end

  def confirm_friend(user)
    friendships = friendship_requests.find { |friendship| friendship.requesting_user == user }
    friendships.request_status = true
    friendships.save
    current_user = friendships.receiving_user
    other_friendship = current_user.friendships.build(receiving_user: user, request_status: true)
    other_friendship.save
  end

  def reject_friend(user)
    friendships = friendship_requests.find { |friendship| friendship.requesting_user == user }
    friendships.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
