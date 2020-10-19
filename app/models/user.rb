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
  has_many :inverse_friendships, class_name: 'Friendship',
                                  foreign_key: 'friend_id', dependent: :destroy

  def pending_sent_requests
    friendships.pending
  end

  def friend_requests
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

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end
end
