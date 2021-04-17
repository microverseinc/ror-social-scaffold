class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :requested_friends, foreign_key: 'requested_id', class_name: 'Friendship'
  has_many :received_friends, foreign_key: 'receiver_id', class_name: 'Friendship'



  def friends
    req_array = requested_friends.map{|friendship| friendship.friend if friendship.confirmed}
    inverse_array = inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
    (friends_array + inverse_array).compact
  end

  def pending_friends
    requested_friends.map{|friendship| friendship.friend if !friendship.confirmed}.compact
  end

  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.confirmed}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
