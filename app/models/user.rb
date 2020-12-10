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
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
 

  def friends
    friends_array = friendships.map do |friendship|
      friendship.friend if friendship.confirmed
    end + inverse_friendships.map do |friendship|
            friendship.user if friendship.confirmed
          end

    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |inverse_friendship| inverse_friendship.user == user }

    friendship.confirmed = true

    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
  def requester?(user)
    id == Friendship.find_friendships(self ,user).first.requester_id
  end
end
