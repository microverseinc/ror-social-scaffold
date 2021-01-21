class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  scope :accepted_requests, -> {sent_friend_requests.where("status = ?", :accepted)}

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_friend_requests, class_name: 'Friendship', foreign_key: :user_id
  has_many :recieved_friend_requests, class_name: 'Friendship', foreign_key: :friend_id


  def friends 
    accepted_requests = sent_friend_requests.map { |request| request.friend if request.status = :accepted }
    requests_accepted = recieved_friend_requests.map { |request| request.user if request.status = :accepted }

    accepted_requests + requests_accepted
  end

  def pending_friend_requests
    recieved_friend_requests.where('status: ?', :pending )
  end

  def accept_request(user)
    request = recieved_friend_requests.where(user_id: user.id)
    request.update(status: :accepted)
  end


end
