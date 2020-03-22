class User < ApplicationRecord
  after_save :create_gravatar
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

  # Users who have yet to confirme friend requests
  has_many :pending_friends, lambda {
                               User.joins(friendships: [:friend]).select('friends_friendships.*')
                                 .where('friendships.confirmed = ?', false)
                             }, class_name: 'User', foreign_key: 'id'

  # Users who have requested to be friends
  has_many :friend_requests, lambda {
                               User.joins(inverse_friendships: [:user]).select('users_friendships.*')
                                 .where('friendships.confirmed = ?', false)
                             }, class_name: 'User', foreign_key: 'id'

  def friends
    friends_array = friendships.map do |friendship|
      friendship.friend if friendship.confirmed
    end
    friends_array += inverse_friendships.map do |friendship|
      friendship.user if friendship.confirmed
    end
    friends_array.compact
  end

  def timeline_posts
    timeline_array = friends.map do |friend|
      friend.posts
    end
    timeline_array += posts.map do |post| post end
    timeline_array.flatten.compact
  end

  def confirm_friend(user)
    friendships = inverse_friendships.find { |friendship| friendship.user == user }
    friendships.update_attribute('confirmed', true)
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending?(user)
    pending_friends.any? { |pending| pending == user }
  end

  def create_gravatar
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    gravatar_url = "https://s.gravatar.com/avatar/#{gravatar_id}?s=80"
    update_column(:gravatar_url, gravatar_url)
  end
end
