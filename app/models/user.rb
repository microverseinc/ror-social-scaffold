class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

    def friends
     friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
     friends_array2 = inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
     friends_array.concat(friends_array2)
     friends_array.compact
     friends_array.compact.uniq
  end
   

  # Users who have yet to confirmed friend invites
  def pending_invites
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_invites(user_id)
    friendship = friendships.where(friend_id: user_id).first
    true if friendship && friendship.confirmed == false
  end

  def receive_invitation(user_id)
    friendship = inverse_friendships.where(user_id: user_id).first
    true if friendship && friendship.confirmed == false
  end

  def send_invitation(user_id)
    @friendship = Friendship.new(user_id: id, friend_id: user_id)
    @friendship.confirmed = false
    @friendship.save
  end

  def confirm_invites(user)
    friendship = inverse_friendships.where(user_id: user).first
    friendship.confirmed = true
    friendship.save
    reverse_confirmation = friendships.create(friend_id: user)
    reverse_confirmation.confirmed = true
    reverse_confirmation.save
  end

 
  def reject_invites(user)
    friendship = inverse_friendships.where(user_id: user).first
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end