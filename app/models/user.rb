class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :active_friendships, class_name: 'Friendship', foreign_key: :requester_id, dependent: :destroy
  has_many :requests, through: :active_friendships, source: :addressee

  has_many :passive_friendships, class_name: 'Friendship', foreign_key: :addressee_id, dependent: :destroy
  has_many :addressees, through: :passive_friendships, source: :requester

  def send_friend_request_to(user)
    active_friendships.create(addressee_id: user.id)
  end

  def accept_friend_request_of(user)
    friend_request = passive_friendships.find_by(requester_id: user.id)
    friend_request.accepted!
  end

  def delete_friend_request_of(user)
    friendship = Friendship.find_by(requester: user, addressee: self) ||
                 Friendship.find_by(addressee: user, requester: self)

    friendship.destroy
  end

  def friend_lists
    friends = active_friendships.map { |f| f.addressee if f.accepted? }
    friends += passive_friendships.map { |f| f.requester if f.accepted? }
    friends.compact
  end

  def pending_friend_lists
    friends = passive_friendships.map { |f| f.requester if f.pending? }
    friends.compact
  end

  def mutual_friends_with(user)
    mutual_friends = friend_lists + user.friend_lists

    mutual_friends.reject do |friend|
      friend.id == id || friend.id == user.id || !friend?(friend) || !user.friend?(friend)
    end.uniq
  end

  def friend?(user)
    friend_lists.include?(user)
  end

  def friend_request_pending_from?(user)
    Friendship.where(requester: user, addressee: self, status: :pending).exists?
  end

  def friend_request_pending_to?(user)
    Friendship.where(requester: self, addressee: user, status: :pending).exists?
  end

  def no_relation?(user)
    !friend?(user) && !friend_request_pending_from?(user) && !friend_request_pending_to?(user)
  end
end
