class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: 'user_id'
  has_many :friends, class_name: 'User', through: 'friendships'

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, source: 'user', through: 'inverse_friendships'

  def all_friends
    @inverse_friends = inverse_friendships.confirmed.map(&:user)
    @friends = friendships.confirmed.map(&:friend)
    (@inverse_friends + @friends).compact
  end
end
