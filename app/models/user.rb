class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Friendship
  has_many :friendships, -> { where(status: 'confirmed') }
  has_many :friends, through: :friendships

  has_many :friend_requests_sent, -> { where(status: 'pending') },
           class_name: 'Friendship', foreign_key: 'user_id'
  has_many :friend_requests_received, -> { where(status: 'pending') },
           class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :friend_requests_received, source: :user

  def friend?(user)
    friendship = Friendship.find_by(user_id: user.id, friend_id: id, status: 'confirmed') ||
                 Friendship.find_by(user_id: id, friend_id: user.id, status: 'confirmed')
    true unless friendship.nil?
  end
end
