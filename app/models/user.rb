class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :sent_requests, class_name: 'Friendship', foreign_key: 'user_id'

  def self.sent_request?(signed_in_user, other_user)
    friendship_sent = Friendship.where('user_id = ? AND friend_id = ?', signed_in_user.id, other_user.id)
    if friendship_sent.empty?
      false
    else
      true
    end
  end

  def self.friends?(signed_in_user, other_user)
    friend_approved = Friendship.where('user_id = ? AND friend_id = ? AND status = ?', signed_in_user.id,
                                       other_user.id, 'approved')
    if friend_approved.empty?
      false
    else
      true
    end
  end
end
