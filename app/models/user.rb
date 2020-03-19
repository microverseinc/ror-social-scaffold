class User < ApplicationRecord
  attr_reader :friends_array
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

  # Users who have yet to confirme friend requests
  has_many :pending_friends, lambda {
                               User.joins(friendships: [:friend]).select('friends_friendships.*')
                                 .where('friendships.confirmed = ?', false)
                             }, class_name: 'User', foreign_key: 'id'

  # Users who have requested to be friends
  has_many :friend_requests, lambda {
                               User.joins(inverse_friendships: [:user]).select('users_friendships.*')
                                 .where('friendships.confirmed = ?', false)
                             }, class_name: 'User', foreign_key: 'id'

  def friends
    friends_array = friendships.map do |friendship|
      friendship.friend if friendship.confirmed
    end
    friends_array += inverse_friendships.map do |friendship|
      friendship.user if friendship.confirmed
    end
    friends_array.compact
  end

  def confirm_friend(user)
    friendships = inverse_friendships.find { |friendship| friendship.user == user }
    friendships.update_attribute('confirmed', true)
  end

  def friend?(user)
    friends.include?(user)
  end
end
