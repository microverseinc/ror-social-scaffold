class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :requested_friendships, foreign_key: 'requester_id', class_name: 'Friendship'
  has_many :received_friendships, foreign_key: 'receiver_id', class_name: 'Friendship'

  #  has_many :friendships
  #  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  def friends
    requested_array = requested_friendships.map { |fr| fr.receiver if fr.status }
    received_array = received_friendships.map { |fr| fr.requester if fr.status }
    (requested_array + received_array).compact
  end

  def friendships
    requested = requested_friendships
    received = received_friendships
    (requested + received)
  end

  def pending_friends
    requested_friendships.map { |fr| fr.receiver unless fr.status }.compact
  end

  def friend_requests
    received_friendships.map { |fr| fr.requester unless fr.status }.compact
  end

  def confirm_friend(user)
    friendship = received_friendships.find { |fr| fr.requester == user }
    friendship.status = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
