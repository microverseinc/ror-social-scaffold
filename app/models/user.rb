class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :confirmed_friendships, -> { where confirmed: true}, class_name: 'Friendship'
  has_many :friendships, through: :confirmed_friendships

  has_many :pending_friendships, -> { where confirmed: false}, class_name: 'Friendship', foreign_key:'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :inverse_friendships, -> { where confirmed: false}, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverse_friendships

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    confirmed_friendships.include?(user)
  end
end
