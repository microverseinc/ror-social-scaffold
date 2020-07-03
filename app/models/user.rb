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
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'


  # status = 1 --> Friends
  # status = 0 --> Not Friends
  # status = -1 --> Pending Friends


  def friends
    friends_array = []
    friendships.map{|friendship| friends_array << friendship.friend if friendship.status == 1} 
    inverse_friendships.map{|friendship| friends_array << friendship.user if friendship.status == 1}
    friends_array
  end

  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if friendship.status == -1}.compact 
  end

  def pending_friends
    pending_friends_array = []
    friendships.map{|friendship| pending_friends_array << friendship.friend if friendship.status == -1}.compact
    pending_friends_array
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user if friendship.status == -1}
    friendship.status = 1
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  # def unfriend(user)
  #   friendship = inverse_friendships.find{|friendship| friendship.user == user if friendship.status == 1}
  #   friendship.status = 0
  #   friendship.save
  # end

  def reject_friend_request(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user if friendship.status == -1}
    friendship.status = 0
    friendship.save
  end

  def send_friend_request(user, friend)
    new_friend = user.friendships.new(friend_id: friend.id, status: -1)
    new_friend.save
  end
end
