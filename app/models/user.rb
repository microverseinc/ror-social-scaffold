class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :pending_friendships, -> { where Acceptance: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :friends, through: :accepted_friendships
  has_many :accepted_friends, -> { where Acceptance: true }, class_name: 'Friendship'
  has_many :friend_request, through: :inverse_friendships, source: :friend
  has_many :friendships_request, -> { where Acceptance: false }, class_name: 'Friendship'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.Acceptance }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.Acceptance }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.Acceptance }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.Acceptance }.compact
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def accept_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.Acceptance = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
    # This will produce SQL query with IN. Something like: select * from posts where user_id IN (1,45,874,43);
  end
end
