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

  scope :join_friends, lambda { |id|
    joins("LEFT OUTER JOIN friendships ON
             ((friendships.user_id = users.id or
             friendships.friend_id = users.id) and (user_id = #{id} or friend_id = #{id}))")
  }
  scope :users, lambda { |id|
    join_friends(id).select('users.*, friend_id, user_id, friendships.status').where('users.id != ?', id)
      .group('users.id, friend_id, status, user_id')
  }
end
