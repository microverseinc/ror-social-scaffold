class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = []
    friendships.map { |friendship| friends_array << friendship.friend if friendship.confirmed }
    inverse_friendships.map { |friendship| friends_array << friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user } # rubocop:disable Metrics/ShadowingOuterLocalVariable
    friendship.confirmed = true
    friendship.save
  end

  def decline_friend(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user } # rubocop:disable Metrics/ShadowingOuterLocalVariable
    friendship.confirmed
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
