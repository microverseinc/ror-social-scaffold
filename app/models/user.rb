class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.status }
    friends_array.compact
  end

  # Users who have yet to confirmed friend invites
  def pending_invites
    friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  # Users who have requested to be friends
  def friend_invites(user_id)
    friendship = friendships.where(friend_id: user_id).first
    true if friendship && friendship.status == false
  end

  def receive_invitation(user_id)
    friendship = inverse_friendships.where(user_id: user_id).first
    true if friendship && friendship.status == false
  end

  def send_invitation(user_id)
    @friendship = Friendship.new(user_id: id, friend_id: user_id)
    @friendship.status = false
    @friendship.save
  end

  def confirm_invites(user)
    friendship = inverse_friendships.where(user_id: user).first
    friendship.status = true
    friendship.save
  end

  def reject_invites(user)
    friendship = inverse_friendships.where(user_id: user).first
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
