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
  has_many :oposite_friendships, foreign_key: 'friend_id', class_name: 'Friendship', dependent: :destroy

  def friends
    friends = friendships.map do |friendship| 
      friendship.friend if friendship.status
    end
    friends = friends + oposite_friendships.map do |friendship| 
      friendship.user if friendship.status
    end
    friends.compact
  end

  def requested_friends
    friendships.map{ |friendship| friendship.friend if !friendship.status }.compact
  end

  def pending_friends
    oposite_friendships.map{ |friendship| friendship.user if !friendship.status }.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending?(user)
    pending_friends.include?(user)
  end

  def requested?(user)
    requested_friends.include?(user)
  end
end
