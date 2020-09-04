class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :sent_requests, foreign_key: :sender_id, class_name: :FriendRequest, dependent: :destroy
  has_many :received_requests, foreign_key: :receiver_id, class_name: :FriendRequest, dependent: :destroy

  has_many :friendships, foreign_key: :friend_id, class_name: 'Friendship', dependent: :destroy
  has_many :friends, through: :friendships, source: :inverse_friend, dependent: :destroy

  def friend?(user)
    friends.include?(user)
  end

  def pending?(user)
    request_to?(user) || request_from?(user) ? true : false
  end

  def request_to?(user)
    sent_requests.find_by(receiver_id: user.id, status: 'pending')
  end

  def request_from?(user)
    received_requests.find_by(sender_id: user.id, status: 'pending')
  end
end
