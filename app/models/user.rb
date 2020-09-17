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
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :incoming_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :incoming_friends, through: :incoming_friendships, source: :user

  def friend?(user)
    all_friends = friends.include?(user)
    all_friends
  end

  def pending_request_with(user)
    incoming_friends.include? user
  end

  def sent_request?(user)
    pending_friends.include? user
  end

  def confirm_friend(user)
    f = incoming_friendships.find_by(user_id: user)
    f.confirmed = true
    f.save
    Friendship.create(friend: f.user, user: f.friend, confirmed: true)
  end

  def pending_friend?(user)
    pending_friends.include?(user)
  end

  def destroy_friend(user)
    f = inverse_friendships.find { |friendship| friendship.user == user }
    f.destroy
  end

  def remove_friend(user)
    friendship_confirmed = friendships.where(confirmed: true).or(inverse_friendships.where(confirmed: true))
    friendships = friendship_confirmed.where(user_id: user.id).or(friendship_confirmed.where(friend_id: user.id))
    friend = friendships.find { |friendship| friendship.user_id == user.id || friendship.friend_id == user.id }
    friend.destroy
  end

  def friends_and_own_posts
    Post.where(user: (friend_ids + [id]))
  end
end
