class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # rubocop:disable Style/HashSyntax
  # rubocop:disable Lint/Void
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array + inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_request
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    # friendship = user.friendships.find_by friend_id: current_user.id
    # friendship = inverse_friendships.find { |friendship| friendship.user == user }
    friendship = inverse_friendships.find_by user_id: user.id
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
  # rubocop:enable Lint/Void
  # rubocop:enable Style/HashSyntax
end
