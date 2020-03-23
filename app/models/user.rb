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

  def pending_friends
    pending_array = friendships.map { |friendship| friendship.friend if you_sent_it?(friendship) }
    pending_array.compact
  end

  def friend_requests
    request_array = friendships.map { |friendship| friendship.friend if you_sent_it?(friendship.inverse) }
    request_array.compact
  end

  def friends
    friends_array = friendships.map do |friendship|
      friendship.friend if friendship.confirmed
    end
    friends_array.compact
  end

  def timeline_posts
    timeline_array = friends.map { |friend| friend.posts.includes(:likes, :comments) }
    timeline_array += posts.includes(:likes, :comments)
    timeline_array.flatten.compact
  end

  def confirm_friend(user)
    user_to_confirm = friendships.find { |friendship| friendship.friend == user }
    user_to_confirm.update_attribute('confirmed', true)
    user_to_confirm.inverse.update_attribute('confirmed', true)
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

  def you_sent_it?(friendship)
    ((friendship.id < friendship.inverse.id) && !friendship.confirmed)
  end
end
