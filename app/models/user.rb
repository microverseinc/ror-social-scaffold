class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: 'received_friendship_id'
  has_many :friendships, foreign_key: 'sent_friendship_id'
  has_many :received_friendships, through: 'friendships'
  has_many :sent_friendships, through: 'friendships'
end
