class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, :class_name => "Friendship", 
  :foreign_key => "friend_id"

  has_many :friendships_confirmation, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :friendships_confirmation

  has_many :friendships_unaccepted, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :unaccepted_request, through: :friendships_unaccepted, source: :friend

  has_many :reverse_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :reverse_friendships, source: :user

  def friend?(user)
    friends.include?(user)
  end

  def already_friend?(user)
    if unaccepted_request.include?(user)
      true
    elsif friend_requests(user)
      true
    else
      false
    end
  end
end
