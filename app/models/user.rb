class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_mant :inverse_frienships, :class_name => "Friendship", :foreign_key => "friend_id"

  def friends
    friends_array1 = friendships.map{|friendship| friendship.friend if friendship.status}
    friends_array2 = inverse_friendships.map{|friendship| friendship.user if friendship.status}
    [friends_array1, friends_array2].flatten
  end
end
