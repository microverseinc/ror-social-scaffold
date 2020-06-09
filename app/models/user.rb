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
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id

  def friends
    friends = self.friendships.collect{ |x| x.friend_id if x.confirmed }
    friends += self.inverse_friendships.collect{ |x| x.user_id if x.confirmed }
    friends.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
  end

  # Users who have requested to be friends
  def friend_requests
  end

  def confirm_friend(friend)
    self.friendships.find_by(friend_id: friend[:id] ).update(confirmed: true)
  end

  def friend?(user)
  end

end
