class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def friend
    friends_array = friendships.map { |f| f.friend if f.status }
    new_array = friends_array + inverse_friendships.map { |f| f.user if f.status }
    new_array.compact
  end

  def pending_friend
    friendships.map { |f| f.friend unless f.status }.compact
  end

  def friend_requests
    inverse_friendships.map { |f| f.user unless f.status }.compact
  end

  def friend?(user)
    pending_friend.include?(user)
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.status = true
    friendship.save
  end

  # rubocop:disable Layout/LineLength
  def check_friendship?(friend)
    Friendship.where(user_id: id, friend_id: friend.id, status: true).exists? || Friendship.where(user_id: friend.id, friend_id: id, status: true).exists?
  end
  # rubocop:enable Layout/LineLength
end
