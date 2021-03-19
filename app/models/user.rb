class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :friendrequests, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :inverse_friendrequests, class_name: 'Friendrequest', foreign_key: 'friend_id'

  has_many :confirmed_friendrequests, -> { where status: true }, class_name: 'Friendrequest'
  has_many :friends, through: :confirmed_friendrequests

  has_many :pending_friendrequests, -> { where status: false }, class_name: 'Friendrequest', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendrequests, source: :friend

  has_many :inverted_friendrequests, -> { where status: false }, class_name: 'Friendrequest'
  has_many :friend_requests, through: :inverted_friendrequests, source: :user

  def confirm_friend(user)
    friend = Friendrequest.find_by(user_id: user_id, friend_id: id)
    friend.status = true
    friend.save
    Friendrequest.create!(friend_id: user.id, user_id: id, status: true)
  end

  def reject_request(user)
    friendrequest = inverse_friendrequests.find { |f| f.user == user }
    friendrequest.destroy
  end

  def friends_and_own_posts
    Post.where(user_id: friends_ids)
  end

  def friend?(user)
    friends.include?(user)
  end

  def mutual_friends(user)
    friends & user.friends
  end

  def friends_ids
    f_ids = friends.map(&:id)
    f_ids << id
  end
end
