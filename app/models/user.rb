class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :registerable, jwt_revocation_strategy: JwtDenylist

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :inverted_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships, source: :user

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end

  def are_we_friends?(friend_id, current_user)
    friend = User.find(friend_id)
    v = friend.friends.where(id: current_user)
    !v.empty?
  end

  def friendship_request?(friend_id, current_user)
    friend = User.find(friend_id)
    v = current_user.friend_requests.where(id: friend.id)
    !v.empty?
  end

  def pending_friends?(friend_id, current_user)
    friend = User.find(friend_id)
    v = current_user.pending_friends.where(id: friend.id)
    !v.empty?
  end

  def my_friendship(friend_id, current_user)
    friend = User.find(friend_id)
    current_user.friendships.where(friend_id: friend.id)
  end

  def my_request(friend_id, current_user)
    friend = User.find(friend_id)
    current_user.inverse_friendships.where(user_id: friend.id)
  end
end
