class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :invitations, class_name: 'Friendship'
  has_many :friendships, foreign_key: 'friend_id'
  has_many :friends, through: 'friendships'

  def friends_with?(user)
    related?(user, Friendship::ACCEPT)
  end

  def invitation_sent?(user)
    if Friendship.exists?(user: self, friend: user)
      true
    else
      Friendship.exists?(user: user, friend: self)
    end
  end

  private

  def related?(user, status)
    if Friendship.all_of_status(user, status).where_involved(self).empty?
      !Friendship.all_of_status(self, status).where_involved(user).empty?
    else
      true
    end
  end
end
