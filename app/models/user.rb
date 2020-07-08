class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

  def friendable?(current_user)
    !current_user.friends.include?(self)
  end

  def unfriendable?(current_user)
    !friendable?(current_user)
  end
end
