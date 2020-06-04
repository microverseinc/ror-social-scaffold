class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :confirmed_friendships, -> { where(status: true) }, class_name: 'Friendship'
  has_many :accepted_friendships, -> { where(status: true) }, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :friendship_requests, -> { where(status: nil) }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :requested_friendships, -> { where(status: nil) }, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  scope :all_users_except_me, ->(user) { where.not(id: user) }

  def effective_friendship
    confirmed_friendships + accepted_friendships
  end

  def friends
    friends = []
    effective_friendship.each { |f| friends << (confirmed_friendships.include?(f) ? f.friend : f.user) }
    friends
  end

  def friend?(user)
    friends.include?(user)
  end

  def friendship_requested?(user)
    pending_requests = friendship_requests + requested_friendships
    pending_requests.any? { |f| f.user_id == user.id || f.friend_id == user.id }
  end

  def demanding?(user)
    friendship_requests.any? { |f| f.friend_id == user.id }
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.status = true
    friendship.save
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def my_timeline
    friend_ids = []
    friends.each { |f| friend_ids << f.id }
    Post.where(user: (friend_ids + [id]))
  end
end
