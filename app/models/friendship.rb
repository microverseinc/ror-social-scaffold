class Friendship < ApplicationRecord
  validate :validate_friendship

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def validate_friendship
    request_friendship_self
  end

  def request_friendship_self
    friend_id != user_id ? return : errors.add(:base, "Can't ask friendship to self")
  end

  def self.decline_friendship(friendship)
    friendship_id1 = Friendship.where(user_id: friendship[:user_id], friend_id: friendship[:friend_id]).pluck(:id)
    friendship_id2 = Friendship.where(user_id: friendship[:friend_id], friend_id: friendship[:user_id]).pluck(:id)
    Friendship.destroy(friendship_id1)
    Friendship.destroy(friendship_id2)
  end

  def self.accept_friendship(friendship)
    friendship_id1 = Friendship.where(user_id: friendship[:user_id], friend_id: friendship[:friend_id]).pluck(:id)
    friendship_id2 = Friendship.where(user_id: friendship[:friend_id], friend_id: friendship[:user_id]).pluck(:id)
    f1 = Friendship.find_by(id: friendship_id1)
    f1.status = true
    f1.save
    f2 = Friendship.find_by(id: friendship_id2)
    f2.status = true
    f2.save
  end

  def self.request_frinedship(friendship)
    user = User.find(friendship[:user])
    friend = User.find(friendship[:friend])
    user.friendships.create(friend: friend, status: false)
    friend.friendships.create(friend: user, status: nil)
    puts
  end

  def self.check_friendship_status(user, current_user)
    if user.id == current_user.id
      'Self'
    elsif current_user.friendships.where(friend_id: user.id, status: false).exists?
      'Invitation sent'
    elsif user.friendships.where(friend_id: current_user.id, status: false).exists?
      'Requested friendship'
    elsif user.friendships.where(friend_id: current_user.id, status: true).exists?
      'Friends'
    else
      'No relation'
    end
  end

  def self.list_of_friends_ids(current_user)
    friends = current_user.friendships.where(status: true)
    friends_ids = []
    friends_ids << current_user.id
    friends.each { |n| friends_ids << n.friend_id }
    friends_ids
  end
end
