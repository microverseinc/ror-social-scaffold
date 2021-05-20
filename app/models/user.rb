class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :senders, foreign_key: 'sender_id', class_name: 'Friendship', dependent: :destroy
  has_many :receivers, foreign_key: 'receiver_id', class_name: 'Friendship', dependent: :destroy
end
