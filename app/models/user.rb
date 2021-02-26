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
  has_many :friends, through: :friendships, foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    inverse_friends_array = inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    (friends_array + inverse_friends_array).compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendships = inverse_friendships.find { |friendship| friendship.user == user }
    friendships.confirmed = true
    friendships.save
  end

  def friend?(user)
    friends.include?(user)
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
