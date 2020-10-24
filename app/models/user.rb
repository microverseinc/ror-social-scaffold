class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  # :validatable

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save :downcase_email

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id', dependent: :destroy
  has_many :pending_friends, -> { merge(Friendship.pending) }, through: :friendships, source: :friend
  has_many :friend_requests, -> { merge(Friendship.pending) }, through: :inverse_friendships, source: :user

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed } +
                    inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact.sort_by(&:created_at).reverse
  end

  def friend?(user)
    friends.include?(user)
  end

  def send_request(friend)
    friendship = friendships.build(friend_id: friend.id)
    friendship.save
  end

  def accept_friend(user)
    new_friend = inverse_friendships.find { |friendship| friendship.user == user }
    return unless new_friend

    new_friend.confirmed = true
    new_friend.save
  end

  def reject_friend(user)
    new_friend = inverse_friendships.find { |friendship| friendship.user == user }
    new_friend.delete
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
