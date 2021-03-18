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
  def friends
    friends_array = friendrequests.map { |friendrequest| friendrequest.friend if friendrequest.status } +
                    inverse_friendrequests.map { |friendrequest| friendrequest.user if friendrequest.status }
    friends_array.compact
  end

  def pending_friends
    friendrequests.map { |friendrequest| friendrequest.friend if !friendrequest.status || friendrequest.nil? }.compact
  end

  def friend_requests
    inverse_friendrequests.map { |friendrequest| friendrequest.user if !friendrequest.status || friendrequest.nil? }.compact
  end

  def confirm_friend(user)
    friendrequest = inverse_friendrequests.find { |f| f.user == user }
    friendrequest.status = true
    friendrequest.save
  end

  def reject_request(user)
    friendrequest = inverse_friendrequests.find { |f| f.user == user }
    friendrequest.destroy
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
