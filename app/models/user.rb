class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: {maximum: 20}

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  # Returns an array with the friends
  def friends
    friends_array = friendships.map do |friendship|
      friendship.friend if friendship.confirmed?
    end
    friends_array += inverse_friendships.map do |friendship|
      friendship.user if friendship.confirmed?
    end
    friends_array
  end

  def friends_requests_sent
    friendships.map do |friendship|
      friendship.friend unless friendship.confirmed?
    end
  end

  def friends_requests_received
    inverse_friendships.map{ |friendship| 
      friendship.user unless friendship.confirmed?
    }
  end

  def friend?(user)
    friends.include?(user)
  end

  def friend_request_sent?(user)
    friendships.include?(user)
  end

  def current_user
    User.find(session[:id])
  end
end
