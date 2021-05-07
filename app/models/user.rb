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
  has_many :inverted_friendships, class_name: 'Friendship', foreign_key: :friend_id

  has_many :friends, through: :friendships

  has_many :sent_requests, class_name: 'Friendship', dependent: :destroy, foreign_key: :user_id
  has_many :received_requests, class_name: 'Friendship', dependent: :destroy, foreign_key: :friend_id

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    Friendship.where(friend_id: id, confirmed: false)
  end

  def pending_requests
    friend_requests.map(&:user).compact
  end

  def pending_friendship(user)
    friend_requests.find { |friendship| friendship if friendship.user == user }
  end

  def pending_friendship?(user)
    !pending_friendship(user).nil?
  end

  def confirm_friend(user)
    friendship = friend_requests.find { |f| f.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def reject_friend(user)
    friendship = friend_requests.find { |f| f.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
