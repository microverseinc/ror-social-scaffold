class User < ApplicationRecord
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", 
  :foreign_key => "friend_id"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def friend
    friend_arr = friendships.map{|friendship| friendship.friend 
    if friendship.status}

      friend_arr + inverse_friendships.map{|friendship| 
      friendship.user if friendship.status}
      friend_arr.compact
  end

  def pending_friends
    friendships.map{|friendship| friendship.friend 
    if !friendship.status}.compact
  end

  def friend_request
    inverse_friendships.map{|friendship| friendship.user
    if !friendship.status }.compact
  end
end
