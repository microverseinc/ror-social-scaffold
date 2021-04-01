class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendies, -> { where confirmed: true }
  has_many :request_received, -> { where confirmed: false }, class_name: 'Friendie', foreign_key: 'friend_id'
  has_many :request_sent, -> { where confirmed: false }, class_name: 'Friendie', foreign_key: 'user_id'

  def friends
    friends_array = friendies.map { |friendie| friendie.friend if friendie.confirmed }
    friends_array + inverse_friendies.map { |friendie| friendie.user if friendie.confirmed }
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendies.map { |friendie| friendie.friend unless friendie.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendies.map { |friendie| friendie.user unless friendie.confirmed }.compact
  end

  def confirm_friend(user)
    friendie = inverse_friendies.find { |frnd| frnd.user == user }
    friendie.confirmed = true
    friendie.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
