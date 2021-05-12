class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :inverted_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :friendships, class_name: 'Friendship', foreign_key: 'user_id', dependent: :destroy
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where confirmed: false }, class_name: "Friendship", foreign_key: "user_id"
  has_many :pending_friends, through: :pending_friendships, source: :friend

  def friendship_requests
    inverted_friendships.map { |invitation| invitation.user if invitation.confirmed == false }.compact
  end

  def confirm_friend(user)
    friendship = inverted_friendships.find { |invitation| invitation.user == user }
    friendship.confirmed = true
    friendship.save
    inverted_friendship = Friendship.new(user_id: friendship.friend_id, friend_id: friendship.user_id, confirmed: true)
    inverted_friendship.save
  end

  def friend?(user)
    friends.include? user
  end

  def invited_by?(user)
    inverted_friendships.one? { |invitation| invitation.user == user and invitation.confirmed == false }
  end

  def destroy_friendship(user)
    received_invitation = inverted_friendships.find_by(user_id: user.id)
    if received_invitation.confirmed == false
      received_invitation.destroy
    elsif received_invitation.confirmed == true
      received_invitation.destroy
      friendships.find_by(friend_id: user.id).destroy
    end
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self)).ordered_by_most_recent
  end
end
