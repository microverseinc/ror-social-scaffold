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
  has_many :inverse_friendships, class_name: :Friendship, foreign_key: :friend_id

    def total_friends
      invitation_sent = friendships.each{|friendship| friendship.friend if friendship.comfirmed ==true }
      invitation_received = inverse_friendship.each{|friendship| friendship.user if friendship.confirmed==true }
      my_friends = invitation_sent + invitation_received
    end

    def pending_friends
      friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
    end

    def friend_requests
      inverse_friendships.map{|friendship| friendship.user if !friendship.confirmed}.compact
    end

    def confirm_friend(user)
      friendship = inverse_friendships.find{|friendship| friendship.user == user }
      frienship.comfirmed = true
      friendship.save 
    end

    def friend?(user)
      friends.include?(user)
    end
end
