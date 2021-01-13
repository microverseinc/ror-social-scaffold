class Friendship < ApplicationRecord
  STATUSES = %w[confirmed rejected pending].freeze
  attribute :status, :string, default: 'pending'

  belongs_to :user
  belongs_to :friend, class_name: :User

  validates_presence_of :user_id, :friend_id, :status
  validates_inclusion_of :status, in: STATUSES
end
