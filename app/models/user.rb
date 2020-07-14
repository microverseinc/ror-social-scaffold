class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  has_many :friendships
  has_many :pending_friendships, -> { where(confirmed: false) }, class_name: 'Friendship'
  has_many :confirmed_friendships, -> { where(confirmed: true) }, class_name: 'Friendship'
  has_many :posts # as: Author, class_name Posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    # friends_array += inverse_friendships.map { |friendship| friendship.friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
