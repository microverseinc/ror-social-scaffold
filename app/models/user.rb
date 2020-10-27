class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :reverse_friendship, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :pending_request, -> { where confirm: false }, class_name: 'Friendship', foreign_key: 'friend_id'


  def add_friend(another_user)
    self.friendships.create(friend_id: another_user)
  end

  def pending_request
      results=[]
      self.reverse_friendship.each do |request|
        if request.confirm == false
          results << request.user
        end
      end
      results
  end

  def sent_request
    results=[]
      self.friendships.each do |request|
        if request.confirm == false
          results << request.friend
        end
      end
      results
  end

  def accept_request(user_id)
    accept = reverse_friendship.find_by(user_id: user_id)
    accept.confirm = true
    accept.save
  end

  def reject_request(user_id)
    accept = reverse_friendship.find_by(user_id: user_id)
    accept.delete
  end

  def friends
    friend_list = self.friendships.map{|friendship| friendship.friend if friendship.confirm}
    friend_list += self.reverse_friendship.map{|friendship| friendship.user if friendship.confirm}
    friend_list.compact
  end

  def is_friend?(user)
    friends.include?(user)
  end

end
