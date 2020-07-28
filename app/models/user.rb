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
  has_many :pending_friendships, -> { where confirmed: nil }, class_name: 'Friendship', foreign_key: "friend_id"

  def friends
    friends_i_sent_friendship = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_friendship = Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_sent_friendship + friends_i_got_friendship
    User.where(id: ids)
  end

  def friend_with?(user)
    Friendship.confirmed_record?(id, user.id)
  end

  def send_request(user)
    friendships.create(friend_id: user.id)
  end
  
end
