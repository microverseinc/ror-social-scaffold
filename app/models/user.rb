class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: :inviter_id
  has_many :invitations, class_name: 'Friendship', foreign_key: :invitee_id

  def friends
    friends_array = friendships.map { |friendship| friendship.invitee if friendship.status }
    invitations_array = invitations.map { |invitation| invitation.inviter if invitation.status }
    friends_array.compact + invitations_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.invitee unless friendship.status }.compact
  end

  def friend_requests
    invitations.map { |invitation| invitation.inviter unless invitation.status }.compact
  end

  def friend?(user)
    friends.include?(user)
  end
end
