class Friendship < ApplicationRecord 
  validate :validate_friendship
  
  def validate_friendship
    request_friendship_self
    friendship_already_requested
  end  

  def request_friendship_self
    self.friend_id != self.user_id  ? return : errors.add(:base, "Can't ask friendship to self")
  end  

  def friendship_already_requested
    :friendship_requested  ? return : errors.add(:base, "Can't ask friendship to self")
  end  

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # scope :friendship_requested, -> { where(friend_id: u.id).exists? }
end
