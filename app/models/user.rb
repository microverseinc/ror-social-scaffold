class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :sent_requests, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :sent_friends, through: :sent_requests, source: :friend
  has_many :incoming_requests, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :incoming_friends, through: :incoming_requests, source: :user
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :confirmed_friends, through: :confirmed_friendships, source: :friend

  def friendship_with?(other_user)
    confirmed_friendships.find { |friendship| friendship if friendship.friend == other_user }
  end

  def sent_invite?(other_user)
    sent_requests.find { |request| request if request.friend == other_user }
  end

  def incoming_invite?(other_user)
    incoming_requests.find { |request| request if request.user == other_user }
  end
end
