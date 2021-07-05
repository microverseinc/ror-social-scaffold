class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 3..20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :friendship_invitees, foreign_key: :inviter_id, class_name: 'Friendship'
  has_many :invitees, through: :friendship_invitees
  has_many :friendship_inviters, foreign_key: :invitee_id, class_name: 'Friendship'
  has_many :inviters, through: :friendship_inviters

  def friends
    invitee_friends + inviter_friends
  end

  def friends_unfiltered
    invitees + inviters
  end

  def pending_inviter_friends
    inviter_ids = friendship_inviters.pending.select(:inviter_id)
    User.where(id: inviter_ids)
  end

  def pending_invitee_friends
    invitee_ids = friendship_invitees.pending.select(:invitee_id)
    User.where(id: invitee_ids)
  end

  def not_acquaintances
    User.where.not(id: id) - friends_unfiltered
  end

  private

  def invitee_friends
    invitee_ids = friendship_invitees.accepted.select(:invitee_id)
    User.where(id: invitee_ids)
  end

  def inviter_friends
    inviter_ids = friendship_inviters.accepted.select(:inviter_id)
    User.where(id: inviter_ids)
  end
end
