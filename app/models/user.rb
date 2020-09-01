class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :sent_requests, foreign_key: :sender_id, class_name: :FriendRequest   
  has_many :received_requests, foreign_key: :receiver_id, class_name: :FriendRequest

  has_many :friendships, foreign_key: :friend_id
  has_many :friends, through: :friendships

  def friendship_joins
    friends_array = friendships.map{|friendship| friendship.user }
    .concat(friendships.map{|friendship| friendship.friend})
    friends_array.compact
  end

  def friend?(user)
    friendship_joins.include?(user)
  end
end
