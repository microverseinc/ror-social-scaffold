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
    friends_array + inverse_friendships.map do |friendship|
      friendship.user if friendship.confirmed?
    end
  end

  def pending_friends
    friendships.map do |friendship|
      friendship.friend unless friendship.confirmed?
    end
  end
end
