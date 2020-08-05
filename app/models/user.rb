class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, uniqueness: true, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_list = friendships.map { |friendship| friendship.friend if friendship.status }

    friends_list += inverse_friendships.map { |friendship| friendship.user if friendship.status }

    friends_list.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  def friendship_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  def confirm_friendship(user)
    friendship_record = inverse_friendships.find { |friendship| friendship.user == user }
    friendship_record.status = true
    friendship_record.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
