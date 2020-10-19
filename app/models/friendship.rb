class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :friend_id, presence: true

  scope :accepted, -> { where('confirmed =?', true) }
  scope :pending, -> { where('confirmed =?', false) }
end
