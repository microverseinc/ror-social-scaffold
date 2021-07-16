class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # rubocop:disable Lint/ShadowingOuterLocalVariable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friends, -> { where status: nil }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :friend_requests, through: :inverse_friendships, source: :user

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user }
    friendship.status = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end
  # rubocop:enable Lint/ShadowingOuterLocalVariable
end
