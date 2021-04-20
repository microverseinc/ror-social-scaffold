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
end
