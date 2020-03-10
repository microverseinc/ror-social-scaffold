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
  has_many :confirmed_friends, -> { where(friendships: {confirmed: true}) }, through: :friendships, source: :friend
  has_many :confirmed_inverse_friends, -> { where(friendships: {confirmed: true}) },
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

  def friend_request_sent?(user, friendship_list)
    friendships_array = friendship_ids(friendship_list, user.id)
    return false if friendships_array.empty? || friendships_array.nil?

    current_friendship = Friendship.find(friendships_array[0])
    current_friendship.user.id == id && current_friendship.confirmed == false
  end

  def friend_request_received?(user, friendship_list)
    friendships_array = friendship_ids(friendship_list, user.id)
    return false if friendships_array.empty? || friendships_array.nil?

    current_friendship = Friendship.find(friendships_array[0])
    current_friendship.friend.id == id && current_friendship.confirmed == false
  end

  def current_user
    User.find(session[:id])
  end

  def friendship_ids(friendship_list, friend_id)
    first_friendship_record = friendship_list.find do |friendship|
      friendship[:user_id] == id && friendship[:friend_id] == friend_id
    end
    second_friendship_record = friendship_list.find do |friendship|
      friendship[:user_id] == friend_id && friendship[:friend_id] == id
    end
    friendship_id = []
    friendship_id << first_friendship_record.id unless first_friendship_record.nil?
    friendship_id << second_friendship_record.id unless second_friendship_record.nil?
    friendship_id.sort!
  end
end
