class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :accepted_friendships, through: Friendship.accepted_friendships
  has_many :friends, through: :accepted_friendships
  has_many :pending_friends
  has_many :requested_friends

  def friendable?(current_user)
    false if current_user == self
    current_user.friends.exclude?(self)
  end

  def unfriendable?(current_user)
    friendship = find_friendship(current_user)
    !friendable?(current_user) && friendship.confirmed
  end

  def pending_friendship?(current_user)
    friendship = find_friendship(current_user)
    !friendable?(current_user) && !friendship.confirmed
  end

  def find_friendship(current_user)
    Friendship.find_by_user_id_and_friend_id(id, current_user.id)
  end
end
