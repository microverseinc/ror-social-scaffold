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
  
  def freinds
    friends_array = friendships.map { |friendship| friendship.freind if freindship.status }
    freinds_array += inverse_friendships.map { |freindship| friendship.user if freindship.status }
    friends_array.compact
  end

  def pending_freinds
    friendships.map { |freindship| freindship.friend unless friendship.status }.compact
  end
  
  def friend_requests
    inverse_friendships.map { |freindship| friendship.user unless friendship.status }.compact
  end

  def confirm_freind(user)
    freindship = inverse_freindships.find{ |freindship| friendship.user == user }
    freindship.status = true
    freindship.save
  end

  def friend?(user)
    friends.include?(user)
  end
  
end

