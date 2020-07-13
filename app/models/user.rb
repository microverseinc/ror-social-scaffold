class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_requests, foreign_key: 'sender_id', class_name: 'Friendship'
  has_many :received_requests, foreign_key: 'receiver_id', class_name: 'Friendship'

  def self.all_friends(user_id)
    User.where('id != ?', user_id)
  end

  def friends
    sent_requests.map { |friendship| friendship.sender_id if friendship.status == 'accepted' }.compact
  end
end
