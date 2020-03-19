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
  # has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_user = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    #friends_friend = inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    #total_friends = friends_user + friends_friend
    total_friends = friends_user
    total_friends.compact
  end

  # Users who have yet to confirme friend requests
  # def pending_friends
  #   friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  # end

  # # Users who have requested to be friends
  # def friend_requests
  #   friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  # end

  def friend?(user)
    friends.include?(user)
  end

  def cannot_add?(friend)
    friendships.where(friend_id: friend.id).exists? ||
    friendships.where(user_id: friend.id).exists? ||
      #inverse_friendships.where(user_id: friend.id).exists? ||
      self == friend
  end
end
