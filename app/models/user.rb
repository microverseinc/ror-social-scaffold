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
  
  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    f = inverse_friendships.find { |friendship| friendship.user == user }
    f.confirmed = true
    f.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending_friend?(user)
    pending_friends.include?(user)
  end

  def destroy_friend(user)
    f = inverse_friendships.find { |friendship| friendship.user == user }
    f.destroy
  end

  def remove_friend(user)
    friends_array = friendships.where(confirmed: true).or(inverse_friendships.where(confirmed: true))
    friends_array = friends_array.where(user_id: user.id).or(friends_array.where(friend_id: user.id))
    friend = friends_array.find { |friendship| friendship.user_id == user.id || friendship.friend_id == user.id }
    friend.destroy
  end

  def friends_post(current_user)
    Post.where(user: friends).or(Post.where(user: current_user))
  end
end
