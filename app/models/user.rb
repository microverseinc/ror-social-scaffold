class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships # , :class_name => "Friendship"
  has_many :friends, class_name: 'Friendship', foreign_key: 'friend_id' # , :through => :friendships
end
