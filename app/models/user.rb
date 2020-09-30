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
  has_many :inverse_friendships, class_name: :Friendship, foreing_key: :friend_id

    def total_friends
      invitation_sent = friendships.each{|friendship| friendship.friend if friendship.comfirmed ==true }
      invitation_received = friendship.each{|friendship| friendship.user if friendship.confirmed==true }
      my_friends = invitation_sent + invitation_received
    end


end
