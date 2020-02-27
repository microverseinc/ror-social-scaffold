class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: :sender_id
  has_many :inverse_friendships, class_name: :Friendship, foreign_key: :reciever_id

  def friendship_created?(reciever)
    friendships.find_by(reciever_id: reciever.id).nil? && created_inverse?(reciever)
  end

  def created_inverse?(reciever)
    reciever.friendships.find_by(reciever_id: id).nil?
  end

  def confirm_inverse?(reciever)
    !friendships.find_by(reciever_id: reciever.id, status: false).nil?
  end
end
