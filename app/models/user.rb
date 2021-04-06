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
  has_many :confirmed_friendies, -> { where status: true }, class_name: 'friendie'
  has_many :friends, through: :confirmed_friendies

  # pending_friends(sent from user)
  # Users who have yet to confirme friend requests
  has_many :pending_friendies, -> { where status: nil }, class_name: 'friendie', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendies, source: :friendie

  # friend_requests(sent to user)
  # Users who have requested to be friends
  has_many :inverted_friendies, -> { where status: nil }, class_name: 'friendie', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendies, source: :user

  def confirm_friend(current_user,user)
   friend = friendie.find_by(user_id: user.id, friend_id: current_user) ||
            friendie.find_by(user_id: user.id, friend_id: current_user)
      friend.status = true
      friend.save
  end
  def friendie?(user)
    friendie = friendie.find_by(user_id: user.id, friend_id: id, status:true) ||
             friendie.find_by(user_id: user.id, friend_id:user.id, status:true)
  true unless friendie.nil?
end
end
