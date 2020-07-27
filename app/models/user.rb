class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :pending_friendships, -> { where confirmed: nil }, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  has_many :inverse_friendships, -> { where confirmed: nil }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  def friend_with?(user)
    Friendship.confirmed_record?(id, user.id)
  end

  def send_friend_request(user)
    friendships.create(friend_id: user.id)
  end
end
