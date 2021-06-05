class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  # Users who have requested to be friends
  def friend_requests
    Friendship.where(friend_id: id, status: false)
  end

  def confirm_friend(user)
    friendship = friend_requests.find { |friend| friend.user == user }
    friendship.status = true
    friendship.save
  end

  def reject_friend(user)
    friendship = friend_requests.find { |f| f.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending_friendship(user)
    friend_requests.find { |friendship| friendship if friendship.user == user }
  end

  def pending_friendship?(user)
    !pending_friendship(user).nil?
  end
end
