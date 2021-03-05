class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  enum status: { accepted: 'accepted', pending: 'pending' }
end
