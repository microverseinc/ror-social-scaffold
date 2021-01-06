class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  scope :all_except, ->(user) { where.not(id: user.id) }

  def friend_requests
    inverse_friendships.where(confirmed: nil)
  end

  def friends
    buddy = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    buddy.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def friendship_requested?(user)
    friends_array = friendships.map { |friendship| friendship.friend unless friendship.confirmed }
    friends_array.include?(user)
  end

  def friendship(user)
    friendships.find { |friendship| friendship.friend_id == user.id }
  end
end
