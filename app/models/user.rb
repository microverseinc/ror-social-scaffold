class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships

  # FRIENDS (current_user all friendships that accp = true)
  has_many :confirmed_friendships, -> { where acceptance: true },
           class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  # INVERSE PAIR (current_user as friend_id)
  has_many :inverted_friendships, -> { where acceptance: false },
           class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships

  # PENDING FRIEND (current_user as user_id)
  has_many :pending_friendships, -> { where acceptance: false },
           class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends,
           through: :pending_friendships, source: :friend

  def friends_and_own_posts
    Post.where(user: friends)
      .or(Post.where(user: self)).ordered_by_most_recent
  end
end
