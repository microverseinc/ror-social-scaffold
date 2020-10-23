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
    friendship_id = Friendship.where(user_id: friendship[:user_id], friend_id: friendship[:friend_id]).pluck(:id)
    Friendship.destroy(friendship_id)
  end

  def self.accept_friendship(friendship)
    friendship_id = Friendship.where(user_id: friendship[:user_id], friend_id: friendship[:friend_id]).pluck(:id)
    f1 = Friendship.find_by(id: friendship_id)
    f1.status = true
    f1.save
  end

  def self.undo_friendship(friendship)
    friendship_id = Friendship.where(user_id: friendship[:user_id], friend_id: friendship[:friend_id], status: true).pluck(:id)
    if !friendship_id.empty?
      Friendship.destroy(friendship_id)
      nil
    else
      friendship_id = Friendship.where(user_id: friendship[:friend_id], friend_id: friendship[:user_id], status: true).pluck(:id)
      Friendship.destroy(friendship_id)
      nil
    end
  end

  def self.check_friendship_status(user, current_user)
    if user.id == current_user.id
      'Self'
    elsif current_user.friendships.where(friend_id: user.id, status: false).exists?
      'Invitation sent'
    elsif user.friendships.where(friend_id: current_user.id, status: false).exists?
      'Requested friendship'
    elsif user.friendships.where(friend_id: current_user.id, status: true).exists? || current_user.friendships.where(friend_id: user.id, status: true).exists?
      'Friends'
    else
      'No relation'
    end
  end

  def self.list_of_friends_ids(current_user)
    friends_requested_ids = Friendship.where(friend_id: current_user.id, status: true)
    friends_invited_ids = Friendship.where(user_id: current_user.id, status: true)
    friends_list = []
    friends_requested_ids.each { |n| friends_list << n.user_id }
    friends_invited_ids.each { |n| friends_list << n.friend_id}
    friends_list << current_user.id
    return friends_list
  end 




  
end
