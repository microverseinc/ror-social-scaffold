class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendshipps
  has_many :inverse_friendshipps, class_name: 'Friendshipp', foreign_key: 'friend_id'

  def friends
    friends_array = friendshipps.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array2 = inverse_friendshipps.map { |friendship| friendship.user if friendship.confirmed }
    friends_array3 = friends_array.concat friends_array2
    friends_array3.uniq.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendshipps.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendshipps.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendshipp = inverse_friendshipps.find { |friendship| friendship.user == user }
    friendshipp.confirmed = true
    friendshipp.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def request_accepted(user)
    friendship = friendshipps.where(friend: user)[0]
    friendship.confirmed = true
    friendship.save
  end

  def friend_and_mines_posts
    my_friends = friends
    our_posts = []
    my_friends.each do |f|
      f.posts.each do |p|
        our_posts << p
      end
    end
    posts.each do |p|
      our_posts << p
    end
    our_posts
  end
end
