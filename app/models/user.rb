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
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    confirmed_friendship_by_me = friendships.map { |friendship| friendship.friend_id if friendship.status }
    confirmed_friendship_from_friend = inverse_friendships.map { |friendship| friendship.user_id if friendship.status }
    (confirmed_friendship_by_me + confirmed_friendship_from_friend).compact
  end

  # Users who have YET to confirm friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |mutual_friend| mutual_friend.user == user }
    friendship.status = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  # The other person's pending invitations
  def pending_friends?(user)
    pending_friends.include?(user)
  end

  # The current_user's received invitations
  def friend_requests?(user)
    friend_requests.include?(user)
  end
end
