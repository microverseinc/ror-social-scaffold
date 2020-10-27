class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :pending_request, -> { where confirm: false }, class_name: 'Friendship', foreign_key: 'friend_id'


  def add_friend(another_user)
    # friends << another_user
    current_user.friendships.create(another_user)
  end

  def pending_request
      results = []

      Friendship.each do |request|
        if request.confirm == false
          results << request
        end
      end
      results
  end

  def is_friend?(another_user)
    # friendships.where(friend: another_user).exists?
    friends.include?(another_user)
  end
end
