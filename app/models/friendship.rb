class Friendship < ApplicationRecord
  scope :pending_requests, -> { where(status: false) }
  scope :accepted_requests, -> { where(status: true) }
  
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
