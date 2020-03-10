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
  has_many :confirmed_friends, -> { where(friendships: { confirmed: true }) }, through: :friendships, source: :friend
  has_many :confirmed_inverse_friends, -> { where(friendships: { confirmed: true }) },
           through: :inverse_friendships, source: :user

  # Returns an array with the friends
  def friends
    friends_array = confirmed_friends + confirmed_inverse_friends
    friends_array
  end

  def friends_requests_sent
    friendships.map do |friendship|
      friendship.friend unless friendship.confirmed?
    end
  end

  def friends_requests_received
    inverse_friendships.map do |friendship|
      friendship.user unless friendship.confirmed?
    end
  end

  def friend?(user)
    friends.include?(user)
  end

  def friend_request_sent?(user)
    requests_list = friends_requests_sent
    requests_list.include?(user)
  end

  def friend_request_received?(user)
    requests_list = friends_requests_received
    requests_list.include?(user)
  end

  def current_user
    User.find(session[:id])
  end

  def friendship_id(friendship_list, friend_id)
    correct_friendship = friendship_list.find do |friendship|
      (friendship[:user_id] == id && friendship[:friend_id] == friend_id) ||
        (friendship[:user_id] == friend_id && friendship[:friend_id] == id)
    end
    correct_friendship.id
  end
end
