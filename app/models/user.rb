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

  def friends
    friends_array = friendships.map{|friendship| friendship.receiving_user if friendship.request_status}
    friends_array + friendship_requests.map{|friendship| friendship.requesting_user if friendship.request_status}
    friends_array.compact
  end

  def pending_friends
    friendships.map{|friendship| friendship.receiving_user unless friendship.request_status}.compact
  end

  def friend_requests
    friendship_requests.map{|friendship| friendship.requesting_user unless friendship.request_status}.compact
  end

  def confirm_friend(user)
    friendship = friendship_requests.find{|friendship| friendship.requesting_user == user}
    friendship.request_status = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
