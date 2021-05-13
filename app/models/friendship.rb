class Friendship < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'


  # private
  def self.requested_before?(sender_id,receiver_id)
    Friendship.find_each do |friendship|
      if (friendship.receiver_id = receiver_id && friendship.sender_id = sender_id) ||
      (friendship.receiver_id = sender_id && friendship.sender_id = receiver_id)
        return true
      end
    end
    return false
  end
end
