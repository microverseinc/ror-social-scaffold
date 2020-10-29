class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  # :validatable

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save :downcase_email

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :confirmed_friendships, -> { where('confirmed = ?', true) },
                                  class_name: 'Friendship', dependent: :destroy
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where('confirmed = ?', false) },
                                  class_name: 'Friendship', foreign_key: 'user_id', dependent: :destroy

  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :inverse_friendships, -> { where('confirmed = ?', false) },
                                  class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  has_many :friend_requests, through: :inverse_friendships, source: :user
  
  def friend?(user)
    friends.include?(user)
  end

  def send_request(friend_id)
    friendship = Friendship.new(user_id: id, friend_id: friend_id)
    friendship.save
  end

  def accept_friend(user_id)
    friendship = inverse_friendships.find_by(user_id: user_id)
    return unless friendship

    friendship.confirmed = true
    friendship.save

    Friendship.create(user_id: id, friend_id: user_id, confirmed: true)
  end

  def reject_friend(user_id)
    friendship = inverse_friendships.find_by(user_id: user_id)
    friendship.delete
  end

  def timeline_posts
    friends_ids = friends.map(&:id)
    Post.includes(:user).where('user_id IN (?) OR user_id = ?', friends_ids, id)
  end
 
  private

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
