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

  def friends
    friendships.map { |friendship| friendship.friend if friendship.confirmed }.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def cannot_add?(friend)
    friendships.where(friend_id: friend.id).exists? ||
      friend.friendships.where(friend_id: id).exists? ||
      self == friend
  end
end
