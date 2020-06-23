class Friendship < ApplicationRecord
  belongs_to :confirmer, foreign_key: :confirmer_id, class_name: 'User'
  belongs_to :requester, foreign_key: :requester_id, class_name: 'User'

  #belongs_to :confirmer, :class_name => "User"
  #belongs_to :requester, :class_name => "User"

  validates :confirmer, uniqueness: { scope: :requester, message: 'Friend Request Already Sent' }
end
