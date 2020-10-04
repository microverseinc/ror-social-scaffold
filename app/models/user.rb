class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, foreign_key: :invitor_id, class_name: :Friendship
  has_many :inverse_friendships, foreign_key: :invitee_id, class_name: :Friendship
  # rubocop: disable Lint/Void
  def friends
    friends_array = friendships.map { |friendship| friendship.user if friendship.status }
    friends_array + friendships.map { |friendship| friendship.friend if friendship.status }
    friends_array.compact
  end

  # rubocop: enable Lint/Void
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  def friend_requests
    inverse_friendships.map { |_frienship| friendship.user unless friendship.status }.compact
  end

  # rubocop: disable Lint/ShadowingOuterLocalVariable
  def confirm_friend(invitor)
    friendship = inverse_friendships.find { |friendship| friendship.invitor == invitor }
    friendship.status = true
    friendship.save
  end

  # rubocop: enable Lint/ShadowingOuterLocalVariable
  def friend?(invitor)
    friends.include? invitor
  end
end
