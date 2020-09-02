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

  has_many :friendships, foreign_key: :friend_id, class_name: "Friendship"
  has_many :friends, through: :friendships, source: :friend
  has_many :inverse_friends, through: :friendships, source: :inverse_friend

  def friend?(user)
    inverse_friends.include?(user)
  end

  def pending?(user)
    sent_requests.find_by(receiver_id: user.id, status: 'pending')
  end
end
