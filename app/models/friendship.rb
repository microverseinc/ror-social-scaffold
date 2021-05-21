class Friendship < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  # private
  def self.requested_before?(sen_id, rec_id)
    Friendship.find_each do |friendship|
      if (friendship.receiver_id == rec_id && friendship.sender_id == sen_id) ||
         (friendship.receiver_id == sen_id && friendship.sender_id == rec_id)
        return true
      end
    end
    false
  end
end
