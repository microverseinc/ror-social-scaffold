class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :pending, -> { where('confirmed = false') }
  scope :accepted, -> { where('confirmed = true') }
end
