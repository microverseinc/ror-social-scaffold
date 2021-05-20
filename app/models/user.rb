class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'

  def send_request(user)
    friendships.create(sender_id: id, receiver_id: user.id) unless Friendship.requested_before?(id, user.id)
  end

  def pending_requests
    friendships.map { |friendship| friendship.receiver unless friendship.status }
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.sender unless friendship.status }
  end

  def confirm_request(user)
    friendship = inverse_friendships.find { |fs| fs.sender == user }
    friendship.status = true
    friendship.save
  end

  def reject_request(user)
    friendship = inverse_friendships.find { |fs| fs.sender == user }
    friendship.destroy
  end

  def friends
    friends_array =
      inverse_friendships.map { |friendship| friendship.sender if friendship.status } +
      friendships.map { |friendship| friendship.receiver if friendship.status }
    friends_array.compact
  end

  def friend?(user)
    friends.include?(user)
  end
end
