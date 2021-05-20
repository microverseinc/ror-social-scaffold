class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  
  has_many :requests_send, class_name: :Friendship, foreign_key: :user_id
  has_many :requestees, through: :requests_send, source: :friend

  has_many :requests_recieved, class_name: :Friendship, foreign_key: :friend_id
  has_many :requesters, through: :requests_recieved, source: :user
end
