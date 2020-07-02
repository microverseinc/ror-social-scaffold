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





  # def friends
  #   friends_array = friendships.map{|friendship| friendship.friend if friendship.status == 1} 
  #   friends_array + inverse_friendships.map{|friendship| friendship.user if friendship.status == 1}
  #   friends_array.compact
  # end


  def friends
    sent = Friendship.where(user_id: id, status: 1).pluck(:friend_id)
    received = Friendship.where(friend_id: id, status: 1).pluck(:user_id)

    friendship = sent + received

    User.where(id: friendship)
  end



  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if friendship.status == -1}.compact 
  end

  def pending_friends
    friendships.map{|friendship| friendship.friend if friendship.status == -1}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.status = 1
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def reject_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.status = 0
    friendship.save
  end
end
