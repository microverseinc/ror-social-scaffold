class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def friends?(user)
    Friendship.exists?(user_id: current_user.id, friend_id: user)
  end

  def sent_requests
    @requested_friends = []
    @sent_requests = Friendship.where('user_id = ? and confirmed = ?', current_user.id, false)
    @sent_requests.each { |u| @requested_friends << User.find(u.friend_id) }
    @requested_friends
  end
end
