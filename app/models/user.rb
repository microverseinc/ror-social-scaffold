class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
          # :validatable

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save :downcase_email

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship',
                                  foreign_key: 'friend_id', dependent: :destroy

  def pending_requests
    friendships.pending
  end

  def received_requests
    inverse_friendships.pending
  end

  # def friends
  #   Friendship.where('(user_id = ? AND confirmed = true) OR (friend_id = ? AND confirmed = true)', id, id)
  # end

  def friends    
    friends_array = friendships.map{|friendship| friendship.friend if friendship.confirmed} +
    inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
    friends_array.compact.sort_by(&:created_at).reverse
  end

  def friend?(user)
    friends.include?(user)
  end

  private

  def accept_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    if friendship
      friendship.confirmed = true
      friendship.save
    end
  end

  def reject_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    if friendship
      friendship.delete
    end
  end

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
