class User < ApplicationRecord
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

 
  has_many :friends, class_name: 'Friendship', foreign_key: 'friend_id'

  
  has_many :pending_friendships, -> { where status: nil }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  
  has_many :friendships
  has_many :inverted_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships, source: :user

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  def friend?(user)
    friendship = Friendship.find_by(user_id: user.id, friend_id: id, status: true) ||
                 Friendship.find_by(user_id: id, friend_id: user.id, status: true)
    true unless friendship.nil?
  end
end
