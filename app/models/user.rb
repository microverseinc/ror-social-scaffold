class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :inverted_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :friendships, class_name: 'Friendship', foreign_key: 'user_id', dependent: :destroy
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :unconfirmed_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :unconfirmed_friendships, source: :user

  def friend?(user)
    friends.include? user
  end

  def invited_by?(user)
    friend_requests.include? user
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self)).ordered_by_most_recent
  end
end
