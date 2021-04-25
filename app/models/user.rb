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

  def friends
    friends_array = []
    friendships.each { |friendship| friends_array << friendship.friend if friendship.comfirmed }
    inverse_friendships.each { |friendship| friends_array << friendship.user if friendship.comfirmed }
    friends_array.compact
  end

  def comfirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.comfirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.comfirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.comfirmed }.compact
  end

  def pending_friend?(user)
    pending_friends.include?(user)
  end

  def potential_friends(current_user)
    User.all.map { |user| user unless friend?(user) || current_user == user }.compact
  end
end