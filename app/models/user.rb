class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :sent_requests, through: :friendships, source: :sender,class_name: 'User', foreign_key: 'sender_id'
  has_many :recieved_requests, through: :friendships, source: :reciever,class_name: 'User', foreign_key: 'reciever_id'
end
