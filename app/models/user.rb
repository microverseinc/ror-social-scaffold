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
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id

  def sent_invitation
    friends_array = friendships.map(&:friend)
    friends_array.compact
  end

  def received_invitation
    friends_array = inverse_friendships.map(&:user)
    friends_array.compact
  end

  def confirmed_friend?(user)
    sent_invitation.include?(user) && received_invitation.include?(user)
  end

  def sent_to_friend?(user)
    sent_invitation.include?(user)
  end

  def mutual_friends
    friends_array = sent_invitation.map { |friend| friend if friend.confirmed_friend?(self) }
    friends_array.compact
  end
end
