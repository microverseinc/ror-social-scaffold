class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  has_many :friends, through: :friendships

  # def friends
  #   #friends_array = friendships.map{|friendship| friendship.friend if friendship.status}
  #   #friends_array + inverse_friendships.map{|friendship| friendship.user if friendship.status}
  #   #friends_array.compact
  #   has_many :friends, through: :friendships
  # end

  # Users who have yet to confirmee friend invites
  def pending_invites
    friendships.map{|friendship| friendship.friend if !friendship.status}.compact
  end

  # Users who have requested to be friends
  def friend_invites
    inverse_friendships.map{|friendship| friendship.user if !friendship.status}.compact
  end


  def confirm_invites(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.status = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
