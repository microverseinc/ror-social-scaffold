class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
<<<<<<< HEAD
=======

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friends, through: :friendships, foreign_key: 'friend_id'
>>>>>>> master

  has_many :friendships, foreign_key: 'requestor_id'

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship', foreign_key: 'requestor_id'
  has_many :friends, through: :confirmed_friendships, source: :requested

  has_many :pending_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'requestor_id'
  has_many :pending_friends, through: :pending_friendships, source: :requested

  has_many :inverted_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'requested_id'
  has_many :friend_requests, through: :inverted_friendships, source: :requestor

  def user_and_friends_posts
    Post.where(user: friends.to_a << self).ordered_by_most_recent.take(10)
  end

  def create_friendship(user_id, user_friendid)
    friendship = friendships.build(friend_id: user_id, userid_friendid: user_friendid)
    friendship.save if friendship.valid?
  end

  def delete_friend(user_friendid)
    friendship = friendships.find_by_userid_friendid(user_friendid)
    friendship ||= inverse_friendships.find_by_userid_friendid(user_friendid)
    friendship.destroy
  end
end
