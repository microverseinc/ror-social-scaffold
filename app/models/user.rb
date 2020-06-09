class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id

  def friends
    friends = friendships.collect { |friend| friend.friend if friend.confirmed }
    friends += inverse_friendships.collect { |friend| friend.user if friend.confirmed }
    friends.compact
  end

  def pending_friends
    new_friends = friendships.collect { |friend| friend.friend unless friend.confirmed }
    new_friends.compact
  end

  def friend_requests
    requests = inverse_friendships.collect { |friend| friend.friend unless friend.confirmed }
    requests.compact
  end

  def confirm_friend(friend)
    friendships.find_by(friend_id: friend[:id]).update(confirmed: true)
  end

  def friend?(user)
    friends.include?(user)
  end
end
