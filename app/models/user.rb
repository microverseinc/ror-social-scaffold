class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, foreign_key: :invitor_id, class_name: :Friendship, dependent: :destroy
  has_many :inverse_friendships, foreign_key: :invitee_id, class_name: :Friendship, dependent: :destroy
  def friends
    friends_array = friendships.map do |friendship|
      friendship.invitee if friendship.status
    end + inverse_friendships.map do |friendship|
      friendship.invitor if friendship.status
    end
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.invitee unless friendship.status }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.invitor unless friendship.status }.compact
  end

  def confirm_friend(invitor)
    friendship = inverse_friendships.where(invitor_id: invitor.id)
    friendship.update(status: true)
  end

  def friend?(invitor)
    friends.include? invitor
  end
end
