class Friendship < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  enum status: { accepted: 'accepted', pending: 'pending' }
end
