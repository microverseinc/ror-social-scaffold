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
    check_friendship = friendships.find_by(friend_id: other_user.id)
    if check_friendship.nil?
      false
    else
      true
    end
  end

  def friends?(other_user)
    friends1 = friendships.where(user_id: id, friend_id: other_user.id, status: 'approved')
    friends2 = other_user.friendships.where(user_id: other_user.id, friend_id: id, status: 'approved')

    if friends1.empty? and friends2.empty?
      false
    elsif !friends1.empty? or !friends2.empty?
      true
    end
  end

  def check_approval?(other_user)
    check_approval = Friendship.where('user_id = ? AND friend_id = ? AND status = ?', other_user.id, id,
                                      'approved')

    if check_approval.empty?
      false
    else
      true
    end
  end
end
