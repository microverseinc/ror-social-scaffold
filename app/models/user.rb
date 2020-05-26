class User < ApplicationRecord
  include ActiveModel::Validations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_with UserValidation
  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy



  has_many :sent_friendships, foreign_key: :sender_id, class_name: :Friendship
  has_many :received_friendships, foreign_key: :receiver_id, class_name: :Friendship



  has_many :requesting_friends, through: :received_friendships
  has_many :requested_friends, through: :sent_friendships

  

end
