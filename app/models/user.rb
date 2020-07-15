class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_requests
  has_many :friends, class_name: 'FriendRequest', foreign_key: 'friend_id'

  # def friends
  #   friends_array = friend_requests.map{|request| request.friend if request.confirmed}
  #   friends_array + friends.map{|f| f.user if f.confirmed}
  #   friends_array.compact
  # end

  def self.check_request(current_user, friend_id)
    current_user.friend_requests.exists?(friend_id: friend_id)
  end

  scope :exclude_current_user, ->(id) { where('id != ?', id) }
end
