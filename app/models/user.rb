class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :friendrequests
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :inverse_friendrequests, class_name: 'Friendrequest', foreign_key: 'friend_id'

  # rubocop:disable Layout/LineLength
  def send_request(user)
    friendrequests.create(friend_id: user.id) unless Friendrequest.all.find_by(user_id: id, friend_id: user.id) || Friend.all.find_by(user_id: user.id, friend_id: id)
  end
  # rubocop:enable Layout/LineLength

  def friends
    friends = []
    Friendrequest.all.each do |request|
      if request.confirmed == true
        if request.user_id == id
          friends << User.find(request.friend_id)
        elsif requests.friend_id == id
          friends << User.find(request.user_id)
        end
      end
    end
    friends
  end

  def pending_friends
    pending_friend = []
    Friendrequest.all.each do |pending|
      next unless pending.confirmed == false

      pending_friend << pending if pending.friend_id == id
    end
    pending_friend
  end

  def friend_requests
    requests = []
    Friendrequest.all.each do |request|
      next unless request.status == false

      requests << request if request.user_id == id
    end
    requests
  end

  def confirm_friend(_user)
    friendrequest = Friendrequest.find_by(user_id, friend_id: id, status: false)
    friendrequest.update(status: true)
  end

  def reject_friend(user)
    friendrequest = Friendrequest.find_by(user_id: user.id, friend_id: id, status: false)
    friendrequest.destroy
  end

  def confirmed_request
    requests = []
    Friendrequest.all.each do |request|
      next unless request.status == true

      requests << request if request.friend_id == id
    end
    requests
  end

  def friend?(user)
    friends.include?(user)
  end
end
