class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :pending_invitations_received, lambda {
                                            where accepted: false
                                          }, foreign_key: :invitee_id, class_name: 'Friendship', dependent: :destroy
  has_many :who_invited_me, through: :pending_invitations_received, source: :inviter, dependent: :destroy

  has_many :pending_invitations_sent, lambda {
                                        where accepted: false
                                      }, foreign_key: :inviter_id, class_name: 'Friendship', dependent: :destroy
  has_many :who_i_invited, through: :pending_invitations_sent, source: :invitee, dependent: :destroy

  has_many :confirmed_friendships, lambda {
                                     where accepted: true
                                   }, foreign_key: :inviter_id, class_name: 'Friendship', dependent: :destroy
  has_many :friends, through: :confirmed_friendships, source: :invitee, dependent: :destroy

  def friendship_request(user)
    return false if who_i_invited.include?(user) || who_invited_me.include?(user)

    Friendship.create!(inviter: self, invitee: user)
  end

  def accept_request(user)
    friend_request = pending_invitations_received.where(inviter_id: user.id).first
    friend_request.update(accepted: true)
  end

  def reject_request(user)
    friend_request = pending_invitations_received.where(inviter_id: user.id).first
    friend_request.destroy
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending_requests_sent?(user)
    who_i_invited.include?(user)
  end

  def pending_requests_received?(user)
    who_invited_me.include?(user)
  end
end
