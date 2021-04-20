class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :received_invitations, class_name: 'FriendshipInvitation', foreign_key: 'invitee_id'
  has_many :sent_invitations, class_name: 'FriendshipInvitation', foreign_key: 'inviter_id'

  def friends
    friends = received_invitations.map { |invitation| invitation.inviter if invitation.confirmed == true }
    friends << sent_invitations.map { |invitation| invitation.invitee if invitation.confirmed == true }
    friends.compact
  end

  def pending_invitations
    sent_invitations.map { |invitation| invitation.invitee if invitation.confirmed == false }.compact
  end

  def friendship_requests
    received_invitations.map { |invitation| invitation.inviter if invitation.confirmed == false }.compact
  end

  def confirm_friend(user)
    friend_invitation = received_invitations.find { |invitation| invitation.inviter == user }
    friend_invitation.confirmed = true
    friend_invitation.save
  end

  def friend?(user)
    friends.include? user
  end
end
