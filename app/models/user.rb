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

  has_many :sent_requests, class_name: 'Friendship', foreign_key: 'user_id'

  def check_friendship?(other_user)
    check_friendship = self.friendships.find_by(friend_id: other_user.id)
    if check_friendship.nil?
      return false
    else
      return true
    end
  end

  def check_approval?(other_user)
    check_approval = Friendship.where("user_id = ? AND friend_id = ? AND status = ?", other_user.id, self.id, "approved")
    
    if check_approval.empty?
      return false
    else
      return true
    end
  end
end
