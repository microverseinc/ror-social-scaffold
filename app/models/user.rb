class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, :class_name  => "Friendship", :foreign_key => "sender_id" 
  has_many :inverse_friendships, :class_name  => "Friendship", :foreign_key => "receiver_id"

  def friends
     friends_array = 
     friendships.map{|friendship| friendship.sender if friendship.status} + 
     friendships.map{|friendship| friendship.receiver if friendship.status}
    friends_array.compact
  end

  def pending_friends
    friendships.map{|friendship| friendship.receiver if !friendship.status} 
  end

  def friend_requests
    friendships.map{|friendship| friendship.sendedr if !friendship.status} 
  end
  
  def conirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.sender == user}
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

end
