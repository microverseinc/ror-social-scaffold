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

  has_many :requested_friendships,
           class_name: "Friendship", foreign_key: "requester_id"
  has_many :received_friendships,
           class_name: "Friendship", foreign_key: "receiver_id"

  has_many :requested_friends,
           class_name: "User",
           through: :requested_friendships,
           source: :receiver

  has_many :received_friends,
           class_name: "User",
           through: :received_friendships,
           source: :requester

  has_many :confirmed_friendships,
    lambda { |object|
      unscope(where: :user_id)
       .where('(requester_id = ? OR receiver_id = ?) AND (confirmed =? )',
                 object.id, object.id, true)
    },
      class_name: 'Friendship'

  def friends
    requested_friends.or(received_friends)
  end

  # def confirmed_friendships
    # Friendship.where("requester_id =? or receiver_id =?", self.id, self.id)
  # end

  def friendable?(current_user)
    false if current_user == self
    current_user.friends.exclude?(self)
  end

  def unfriendable?(current_user)
    !friendable?(current_user)
  end
end
