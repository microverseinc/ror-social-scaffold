class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map { |f| f.friend if f.confirmed? }
    friends_array += inverse_friendships.map { |f| f.user if f.confirmed? }
    friends_array.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def outgoing_friend_requests
    friendships.map { |f| f if f.pending? }.compact
  end

  def incoming_friend_requests
    inverse_friendships.map { |f| f if f.pending? }.compact
  end
end
