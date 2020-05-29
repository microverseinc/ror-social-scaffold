class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :sent_friendships, foreign_key: :sender_id, class_name: :Friendship
  has_many :received_friendships, foreign_key: :receiver_id, class_name: :Friendship

  has_many :requesting_friends, through: :received_friendships
  has_many :requested_friends, through: :sent_friendships

  def friends
    requested_friends
      .includes(:sent_friendships)
      .where('friendships.status = true')
  end
end
