class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :inverted_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friendships, class_name: 'Friendship', foreign_key: 'user_id'

  def friends
    friends = inverted_friendships.map { |invitation| invitation.user if invitation.confirmed == true }
    friends += friendships.map { |invitation| invitation.friend if invitation.confirmed == true }
    friends.compact
  end

  def pending_invitations
    friendships.map { |invitation| invitation.friend if invitation.confirmed == false }.compact
  end

  def friendship_requests
    inverted_friendships.map { |invitation| invitation.user if invitation.confirmed == false }.compact
  end

  def confirm_friend(user)
    friend_invitation = inverted_friendships.find { |invitation| invitation.user == user }
    friend_invitation.confirmed = true
    friend_invitation.save
  end

  def friend?(user)
    friends.include? user
  end

  def invited_by?(user)
    inverted_friendships.one? { |invitation| invitation.user == user and invitation.confirmed == false }
  end

  def friend_invitation(user)
    received_invitation = inverted_friendships.find { |invitation| invitation if invitation.user == user }
    return received_invitation unless received_invitation.nil?

    friendships.find { |invitation| invitation if invitation.friend == user }
  end
end
