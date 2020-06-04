class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id'

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  scope :all_users_except_me, ->(user) { where.not(id: user) }

  def timeline
    friends_ids = []
    friends.each { |friend| friends_ids << friend.id }
    Post.where(user_id: (friends_ids + [id]))
  end

  def friends
    friends_array = friendships
      .map { |friendship| friendship.friend if friendship.status }

    friends_array += inverse_friendships
      .map { |friendship| friendship.user if friendship.status }
    friends_array.compact
  end

  def pending_friends
    friendships
      .map { |friendship| friendship.friend unless friendship.status }.compact
  end

  def friend_requests
    inverse_friendships
      .map { |friendship| friendship.user unless friendship.status }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.status = true
    friendship.save
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
