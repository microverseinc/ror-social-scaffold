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
  has_many :confirmed_friendships, -> { confirmed }, class_name: 'Friendship'
  has_many :not_confirmed_friendships, -> { not_confirmed }, class_name: 'Friendship'

  has_many :friends,
           class_name: "User", through: :confirmed_friendships, source: :friend

  has_many :not_confirmed_friends,
           class_name: "User", through: :not_confirmed_friendships, source: :friend


  has_many :pending_friends,
           -> (object) {
           where("friend_id = ?", object.id)
           },
           class_name: 'User',
           through: 'not_confirmed_friendships',
           source: 'friend'


  has_many :requested_friends,
           -> (object) {
           where("user_id = ?", object.id)
           },
           class_name: 'User',
           through: 'not_confirmed_friendships',
           source: 'user'

  def pending_friendships
    not_confirmed_friendships.where('user_id =?', id)
  end


  def friendable?(current_user)
    false if current_user == self
    current_user.friends.exclude?(self)
  end

  def unfriendable?(current_user)
    !friendable?(current_user)
  end
end
