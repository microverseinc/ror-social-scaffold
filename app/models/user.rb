class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # rubocop:disable Style/HashSyntax
  # rubocop:disable Lint/Void
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :friends, through: :friendships, :class_name => 'User', :foreign_key => 'user_id'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array + inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_request
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    ActiveRecord::Base.transaction do
      friendship = inverse_friendships.find_by user_id: user.id
      friendship.update!(confirmed: true)
      friendship.save
      inverse_rel = friendships.new(friend_id: user.id, confirmed: true)
      inverse_rel.save!
    end
  end

  def friend?(user)
    friends.include?(user)
  end
  # rubocop:enable Lint/Void
  # rubocop:enable Style/HashSyntax
end
