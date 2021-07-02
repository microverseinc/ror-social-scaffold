class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendship_invitees, foreign_key: :inviter_id, class_name: 'Friendship'
  has_many :invitees, through: :friendship_invitees
  has_many :friendship_inviters, foreign_key: :invitee_id, class_name: 'Friendship'
  has_many :inviters, through: :friendship_inviters

  # has_many :friendship_invitation_invitees, foreign_key: :inviter_id, class_name: 'Friendship', scope: :accepted
  # has_many :friends_invitees, through: :friendship_invitation_invitees
  # has_many :friendship_invitation_inviters, foreign_key: :invitee_id, class_name: 'Friendship', scope: :accepted
  # has_many :friends_inviters, through: :friendship_invitation_inviters


end
