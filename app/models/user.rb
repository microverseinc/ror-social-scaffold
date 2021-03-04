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
    if Friendship.all_friends_of(user).check_friends(self).empty?
      !Friendship.all_friends_of(self).check_friends(user).empty?
    else
      true
    end
  end
end
