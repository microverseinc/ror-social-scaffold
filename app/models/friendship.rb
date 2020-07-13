class Friendship < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  validates :status, presence: true

  def self.get_request(receiver_id, sender_id)
    Friendship.where('receiver_id = ? and sender_id = ?', receiver_id, sender_id)
  end
end
