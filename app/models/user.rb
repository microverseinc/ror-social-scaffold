class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :pending_friendships, -> { where(confirmed: false) }, class_name: 'Friendship'
  has_many :confirmed_friendships, -> { where(confirmed: true) }, foreign_key: 'friend_id', class_name: 'Friendship'
  has_many :posts # as: Author, class_name Posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def friends
    friends_array = friendships.map { |f| f.friend if f.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = friendships.find { |f| f.friend == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending_invitations
    invitations = []
    invitations << pending_friends
    invitations << friend_requests
    invitations
  end

  def friendships_sent(friend)
    friendship = friendships.where(friend_id: friend.id).ids
    friendship[0]
  end

  def friendships_received(friend)
    friendship = friend.friendships.where(friend_id: id).ids
    friendship[0] if friendships.where(friend_id: friend).ids.empty?
  end
end
