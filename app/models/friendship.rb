class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, presence: true
  validates :friend_id, presence: true

  scope :accepted, -> { where('confirmed =?', true).order(updated_at: :desc) }
  scope :pending, -> { where('confirmed =?', false).order(created_at: :desc) }
end
