class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_requests, -> { where confirmed: false }
  has_many :friends, -> { where confirmed: true }, class_name: 'FriendRequest', foreign_key: 'friend_id'

  def self.check_request(current_user, friend_id)
    current_user.friend_requests.exists?(friend_id: friend_id)
  end

  scope :exclude_current_user, ->(id) { where('id != ?', id) }
end
