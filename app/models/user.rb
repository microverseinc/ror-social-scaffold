class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # outgoing  unconfirmed
  has_many :requests_send, 
            class_name: :Friendship, 
            foreign_key: :user_id

  has_many :requestees, 
            through: :requests_send, 
            source: :friend

  # outgoing  confirmed
  has_many :requests_send_confirmed,
              ->{where(confirmed: true)},
            class_name: :Friendship,
            foreign_key: :user_id

  has_many :friends_sent_accepted,
            through: :requests_send_confirmed,
            source: :friend


  # incoming unconfirmed

  has_many :requests_recieved, 
            class_name: :Friendship, 
            foreign_key: :friend_id

  has_many :requesters,
            through: :requests_recieved, 
            source: :user

  # incoming confirmed

  has_many :requests_recieved_confirmed, 
              ->{where(confirmed: true)},
            class_name: :Friendship, 
            foreign_key: :friend_id

  has_many :friends_accepted, 
            through: :requests_recieved_confirmed, 
            source: :user
end
