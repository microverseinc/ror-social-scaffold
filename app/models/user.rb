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

  has_many :friends, -> { where status: true }, class_name: 'Friendship'
  has_many :pending_friends, -> { where status: false }, foreign_key: :user_id, class_name: 'Friendship'
  has_many :friend_requests, -> { where status: false }, foreign_key: :friend_id, class_name: 'Friendship'

  def status?(user)
    status_list = (pending_friends + friends).map(&:friend) + friend_requests.map(&:user) << self
    status_list.include?(user)
  end

  def friends?(user)
    friends.map(&:friend).include?(user)
  end

  def my_self?(user)
    self == user
  end
end
