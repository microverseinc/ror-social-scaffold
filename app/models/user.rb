class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #Friendship associatons

  has_many :friendships, class_name: 'Friendship', foreign_key: 'confirmer_id'
  has_many :confirmers, through: :friendships, source: :confirmer

  has_many :friendships, class_name: 'Friendship', foreign_key: 'requester_id'
  has_many :requesters, through: :friendships, source: :requester

end
