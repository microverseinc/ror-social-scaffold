class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :requests_sent,
           foreign_key: :user_id,
           dependent: :destroy

  has_many :request_recieved,
           foreign_key: :friend_id,
           dependent: :destroy

  has_many :requests_sent_unconfirmed,
           -> { where(confirmed: false) },
           class_name: :Friendship,
           foreign_key: :user_id,
           dependent: :destroy

  has_many :users_requested,
           through: :requests_sent_unconfirmed,
           source: :friend

  has_many :requests_sent_confirmed,
           -> { where(confirmed: true) },
           class_name: :Friendship,
           foreign_key: :user_id,
           dependent: :destroy

  has_many :friends_from_requests_sent,
           through: :requests_sent_confirmed,
           source: :friend

  has_many :requests_recieved_unconfirmed,
           -> { where(confirmed: false) },
           class_name: :Friendship,
           foreign_key: :friend_id,
           dependent: :destroy

  has_many :users_requesting,
           through: :requests_recieved_unconfirmed,
           source: :user

  has_many :requests_recieved_confirmed,
           -> { where(confirmed: true) },
           class_name: :Friendship,
           foreign_key: :friend_id,
           dependent: :destroy

  has_many :friends_from_requests_accepted,
           through: :requests_recieved_confirmed,
           source: :user

  def friends
    (friends_from_requests_sent + friends_from_requests_accepted).uniq
  end

  def friends_ids
    friends_from_requests_sent_ids + friends_from_requests_accepted_ids
  end

  def friend?(user)
    friends_ids.include?(user.id)
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end
end
