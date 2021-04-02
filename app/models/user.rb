class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # confirm friends
  has_many :confirmed_friendships, -> { where status: true }, class_name: 'friendship'
  has_many :friends, through: :confirmed_friendships

  # pending_friends(sent from user)
  # Users who have yet to confirme friend requests
  has_many :pending_friendships, -> { where status: nil }, class_name: 'friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  # friend_requests(sent to user)
  # Users who have requested to be friends
  has_many :inverted_friendships, -> { where status: nil }, class_name: 'friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships, source: :user

  def confirm_friend(current_user,user)
   friend = Friendship.find_by(user_id: user.id, friend_id: current_user) ||
            Friendship.find_by(user_id: user.id, friend_id: current_user)
      friend.status = true
      friend.save
  end
  def friendship?(user)
    friendship = Friendship.find_by(user_id: user.id, friend_id: id, status:true) ||
             Friendship.find_by(user_id: user.id, friend_id:user.id, status:true)
  true unless friendship.nil?
end
end
