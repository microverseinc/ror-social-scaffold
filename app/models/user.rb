class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  has_many :friendships, dependent: :destroy

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def friend
    friendships.map { |friendship| friendship.friend if friendship.status }.compact
  end

  def pending_friend
    friendship.map { |f| f.friend unless friendship.status }.compact
  end

  def friend?(user)
    friend.include?(user)
  end
end
