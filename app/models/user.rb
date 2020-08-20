class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :requests_sent, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :requests_received, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests_sent, through: :requests_sent, source: :request_sender
  has_many :friend_requests_received, through: :requests_received, source: :request_receiver
end
