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
  has_many :confirmed_friendships, -> { confirmed }, class_name: "Friendship"

  has_many :not_confirmed_friendships,
           -> { not_confirmed },
           class_name: "Friendship"

  has_many :friends,
           class_name: "User", through: :confirmed_friendships, source: :friend

  has_many :pending_friendships,
           ->(object) { where("requester_id =? and confirmed=?", object.id, false) },
           class_name: "Friendship"

  has_many :requested_friendships,
           lambda { |object| where("receiver_id =? and confirmed =?", object.id, false) },
           class_name: "Friendship"

  has_many :requested_friends,
           class_name: "User", through: :requested_friendships, source: :user

  has_many :pending_friends,
           class_name: "User", through: :pending_friendships, source: :friend

  def friendable?(current_user)
    false if current_user == self
    current_user.friends.exclude?(self)
  end

  def unfriendable?(current_user)
    !friendable?(current_user)
  end
end
