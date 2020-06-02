class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :inverse_friendship, foreign_key: :friend_id, class_name: 'Friendship'
  has_many :friendships, foreign_key: :user_id, class_name: 'Friendship'

  def friends_list
    friend_list = friendships.map { |f| f.friend if f.status } + inverse_friendship.map { |f| f.user if f.status }
    friend_list.compact
  end

  def pending_list
    pending_list = friendships.map { |f| f.friend unless f.status }
    pending_list.compact
  end

  def request_list
    requested_list = inverse_friendship.map { |f| f.user unless f.status }
    requested_list.compact
  end

  def friendship_status(user)
    if request_list.include?(user)
      'You have a pending friend request from this user'
    elsif pending_list.include?(user)
      'You have already requested this user to be your friend'
    elsif my_self?(user)
      ''
    else
      'Friends'
    end
  end

  def friends?(user)
    friends_list.include?(user)
  end

  def my_self?(user)
    self == user
  end
end
