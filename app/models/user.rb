class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :followers, foreign_key: :follower_id, class_name: 'Follow'
  has_many :leaders, foreign_key: :leader_id, class_name: 'Follow'

  # returns all of the other users
  # who are connected to the given user via a confirmed friendship
  # or confirmed inverse friendship
  def friends
    # user is the follower so we take all of his leaders
    friends_array = followers.map { |follow| follow.leader if follow.status == true }
    # user is the leader so we take all of his followers
    friends_array.concat leaders.map { |follow| follow.follower if follow.status == true }
    friends_array.compact
  end

  # Users who have yet to confirm friend requests
  def pending_friends
    followers.map { |follow| follow.leader unless follow.status }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    leaders.map { |follow| follow.follower unless follow.status }.compact
  end

  def confirm_friend(user)
    follow = leaders.find { |follow| follow.follower == user }
    follow.status = true
    follow.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
