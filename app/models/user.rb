class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: false
  scope :all_except_current_user, ->(user) { where.not(id: user) }

  has_many :requested_friendships,
           -> { requested },
           class_name: 'Friendship'

  has_many :received_friendships,
           -> { received },
           class_name: 'Friendship'

  has_many :confirmed_friendships,
           -> { confirmed },
           class_name: 'Friendship'

  has_many :received_friends,
           class_name: 'User',
           through: :received_friendships,
           source: :friend

  has_many :requested_friends,
           class_name: 'User',
           through: :requested_friendships,
           source: :friend

  has_many :friends,
           class_name: 'User',
           through: :confirmed_friendships,
           source: :friend

  def timeline_posts
    ids = friends.pluck(:id) << id
    Post.all.ordered_by_most_recent.where(user_id: ids).includes(:user)
  end
end
