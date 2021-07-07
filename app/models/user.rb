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
  has_many :friends, through: :friendships, class_name: 'User'

  def pending_inviters
    pending_inviters_ids = Friendship.where(user_id: id, friend_id: User.find(id).friends.select(:id),
                                            status: false).select(:friend_id)
    friends.where(id: pending_inviters_ids)
  end

  def pending_invitees
    pending_invitees_ids = Friendship.where(user_id: User.find(id).friends.select(:id), friend_id: id,
                                            status: false).select(:user_id)
    friends.where(id: pending_invitees_ids)
  end

  def accepted_friends
    friends - pending_inviters - pending_invitees
  end

  def not_acquaintances
    User.where.not(id: id) - friends
  end
end
