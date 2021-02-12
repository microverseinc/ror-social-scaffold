class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :friendships, foreign_key: :requestor_id
  has_many :friendships, foreign_key: :requested_id
  has_many :friends, through: :friendships, source: :requested
  has_many :requestors, through: :friendships, source: :requestor
end
