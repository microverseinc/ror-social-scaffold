class Friendship < ApplicationRecord 
  validate :validate_friendship
  after_destroy 
  
  def validate_friendship
    request_friendship_self
  end  

  def request_friendship_self
    self.friend_id != self.user_id  ? return : errors.add(:base, "Can't ask friendship to self")
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
      return
    else   
      friendship_id = Friendship.where(user_id: friendship[:friend_id], friend_id: friendship[:user_id], status: true).pluck(:id)
      Friendship.destroy(friendship_id)
      return
    end 
  end

  def self.check_friendship_status(user, current_user)
    if user.id == current_user.id
      return "Self"
    elsif current_user.friendships.where(friend_id: user.id, status: false).exists?
      return "Invitation sent"
    elsif user.friendships.where(friend_id: current_user.id, status: false).exists?  
      return "Requested friendship"
    elsif user.friendships.where(friend_id: current_user.id, status: true).exists?  ||  current_user.friendships.where(friend_id: user.id, status: true).exists?
      return "Friends"
    else
      return "No relation" 
  end
  
  end  

  belongs_to :user
  belongs_to :friend, class_name: 'User'


end
