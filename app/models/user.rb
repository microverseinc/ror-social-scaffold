class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id',
                                 dependent: :destroy

  has_many :requested_friends, through: :friendships, source: :friend
  has_many :requested_from_friends, through: :inverse_friendships, source: :user

  def friends
    friendships.map do |friendship|
      friendship.friend if friendship.status
    end.compact
  end

  def pending_requested_friendship
    friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  def pending_requested_from_friendship
    inverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending_requested?(user)
    pending_requested_friendship.include?(user)
  end

  def pending_requested_from?(user)
    pending_requested_from_friendship.include?(user)
  end

  def request_friendship(friend)
    requested_friends << friend
  end
end
