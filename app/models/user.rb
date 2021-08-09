# rubocop:disable Lint/RedundantCopDisableDirective

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friendships_unresolved, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :unresolved_request, through: :friendships_unresolved, source: :friend
  has_many :friendships_confirmation, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :friendships_confirmation
  has_many :reverse_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :reverse_friendships, source: :user

  def friend?(user)
    friends.include?(user)
  end

  def already_friend?(user)
    if unresolved_request.include?(user)
      true
    else
      friend_requests.include?(user)
    end
  end
end
# rubocop:enable Lint/RedundantCopDisableDirective
