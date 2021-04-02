class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_requests, through: :pending_friendships, source: :friend

  has_many :inverse_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverse_friendships, source: :user

  # has_many :friendships
  # has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  # def friends
  #   friends_array1 = friendships.map { |friendship| friendship.friend if friendship.status == true }
  #   friends_array2 = inverse_friendships.map { |friendship| friendship.user if friendship.status == true }
  #   [friends_array1, friends_array2].flatten
  # end

  # def pending_requests
  #   friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  # end

  # def friend_requests
  #   inverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  # end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
    # This will produce SQL query with IN. Something like: select * from posts where user_id IN (1,45,874,43);
  end

  def friend?(user)
    friends.include?(user)
  end
end
