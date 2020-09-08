class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: :friend_id, class_name: 'Friendship', dependent: :destroy

  has_many :friends, through: :friendships, source: :inverse_friend, dependent: :destroy do
    def confirmed
      where('friendships.status = ?', 'confirmed')
    end
  end

  def friend?(user)
    friends.confirmed.include?(user)
  end

  def pending?(user)
    request_to?(user) || request_from?(user) ? true : false
  end

  def request_to?(user)
    Friendship.find_by(friend: self, inverse_friend: user, status: 'pending')
  end

  def request_from?(user)
    Friendship.find_by(friend: user, inverse_friend: self, status: 'pending')
  end
end
