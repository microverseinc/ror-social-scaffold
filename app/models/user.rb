class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # user
  has_many :friendships, foreign_key: 'user_id'
  has_many :friends, class_name: 'User', through: 'friendships'

  # friend
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id' 
  has_many :inverse_friends, source: 'user', through: 'inverse_friendships'

  # def all_friends
  #   friends_array = friendships.map{|friendship| friendship.friend if friendship.status}
  #   friends_array + inverse_friendships.map{|friendship| friendship.user if friendship.status}
  #   friends_array.compact
  # end

  
end
