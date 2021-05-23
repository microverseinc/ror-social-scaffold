class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :invitations_received, foreign_key: :invitee_id, class_name: 'Friendship', dependent: :destroy
  has_many :who_invited_me, through: :invitations_received, source: :inviter, dependent: :destroy

  has_many :invitations_sent, foreign_key: :inviter_id, class_name: 'Friendship', dependent: :destroy
  has_many :who_i_invited, through: :invitations_sent, source: :invitee, dependent: :destroy

def friendship_request(user)
    return false if who_i_invited.include?(user) || who_invited_me.include?(user)

    who_i_invited << user
  end

  def accept_request(user)
    friend_request = invitations_received.where(inviter_id: user.id).first
    friend_request.update(accepted: true)
  end

  def reject_request(user)
    friend_request = invitations_received.where(inviter_id: user.id).first
    friend_request.destroy
  end

  def friends
    User.where(id: invitations_received.where(accepted: true).pluck(:inviter_id))
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def pending_requests_sent?(user)
    pending_requests_i_sent.include?(user)
  end

  def pending_requests_received?(user)
    pending_requests_i_received.include?(user)
  end

  def pending_requests_i_sent
    invitations_sent.map { |friendship| friendship.invitee unless friendship.accepted }
  end

  def pending_requests_i_received
    invitations_received.map { |friendship| friendship.inviter unless friendship.accepted }
  end
end
