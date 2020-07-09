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

  has_many :friends,
           -> { where(confirmed: true) },
           class_name: "User", through: :friendships, source: :friend

  def requested_friendships
    friendships.requested_friendships
  end

  def pending_friendships
    friendships.requested_friendships.where("friend_id =?", id)
  end

  def friendable?(current_user)
    false if current_user == self
    current_user.friends.exclude?(self)
  end

  def unfriendable?(current_user)
    !friendable?(current_user)
  end
end
