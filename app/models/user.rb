class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :requests_send_unconfirmed,
           -> { where(confirmed: false) },
           class_name: :Friendship,
           foreign_key: :user_id

  has_many :users_requested,
           through: :requests_send_unconfirmed,
           source: :friend

  has_many :requests_send_confirmed,
           -> { where(confirmed: true) },
           class_name: :Friendship,
           foreign_key: :user_id

  has_many :friends_from_request_send,
           through: :requests_send_confirmed,
           source: :friend

  has_many :requests_recieved_unconfirmed,
           -> { where(confirmed: false) },
           class_name: :Friendship,
           foreign_key: :friend_id

  has_many :users_requesting,
           through: :requests_recieved_unconfirmed,
           source: :user

  has_many :requests_recieved_confirmed,
           -> { where(confirmed: true) },
           class_name: :Friendship,
           foreign_key: :friend_id

  has_many :friends_from_requests_accepted,
           through: :requests_recieved_confirmed,
           source: :user
end
