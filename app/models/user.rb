class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def sent_requests
    friendships.map { |friendship| friendship unless friendship.confirmed }.compact
  end

  def incoming_requests
    inverse_friendships.map { |friendship| friendship unless friendship.confirmed }.compact
  end

  def friend?(user)
    friendships.find { |friendship| friendship.friend == user if friendship.confirmed } ||
      inverse_friendships.find { |friendship| friendship.user == user if friendship.confirmed }
  end

  def sent_invite(user)
    friendships.find { |friendship| friendship.friend == user unless friendship.confirmed }
  end

  def incoming_invite(user)
    inverse_friendships.find { |friendship| friendship.user == user unless friendship.confirmed }
  end
end
